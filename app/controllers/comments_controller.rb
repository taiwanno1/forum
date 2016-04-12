class CommentsController < ApplicationController

  before_action :find_po

  def index
    @comments = @po.comments.order("id DESC")
    @comment = @po.comments.new
    @comments = @comments.page(params[:page]).per(5)
    @comments_count = @po.comments.count
    @likes = @po.likes

  end

  def create
    @comment = @po.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "新增成功"

      all_users = @po.comments.map{|c| c.user}
      all_users << @po.user
      all_users = all_users.uniq
      all_users.each do |u|
        UserMailer.notify_comment(@po, @comment, u).deliver_later
      end

      respond_to do |format|
        format.html {redirect_to po_comments_path(:page => params[:page])}
        format.js
      end
    else
      flash[:notice] = "新增哭哭"
    end
  end

  def destroy
    flash[:alert] = "comment deleted"
    @comment = @po.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html {redirect_to po_comments_path}
      format.js
    end
  end


private

  def find_po
    @po = Po.find(params[:po_id])
  end

  def comment_params
    params.require(:comment).permit(:name, :comment, :cat_ids => [])
  end

end
