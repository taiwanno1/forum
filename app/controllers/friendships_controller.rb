class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.create!(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "friend added"
      redirect_to :back
    else
      flash[:error] = "add faile"
      redirect_to :back
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])

  end

end
