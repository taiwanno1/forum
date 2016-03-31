class LikesController < ApplicationController
  before_action :autenticate_user!
  before_action :set_po

  def create
    like = @po.find_like_by(current_user)
    if like
      #nothing
    else
      @like = @po.likes.create!( :user => current_user)
    end

    respond_to do |format|
      format.html {redirect_to :back}
      format.js {render "like"}
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    @like = nil

    respond_to do |format|
      format.html {redirect_to :back}
      format.js {render "like"}
    end
  end

private

  def set_po
    @po = Po.find(params[:po_id])
  end

end
