class CommentsController < ApplicationController

  before_action :find_po

  def index
    @comments = @po.comments
    @comment = @po.comments.new
    @comments = @comments.page(params[:page]).per(5)
    @comments_count = @po.comments.count

  end

  def create
    @comment = @po.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to po_comments_path(:page => params[:page])
    else
      redirect_to  po_comments_path
    end
  end

  def destroy
    flash[:alert] = "comment deleted"
    @comment = @po.comments.find(params[:id])
    @comment.destroy
    redirect_to po_comments_path
  end



private

  def find_po
    @po = Po.find(params[:po_id])
  end

  def comment_params
    params.require(:comment).permit(:name, :comment)
  end

end
