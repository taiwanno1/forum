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
    @inverse_friendship = current_user.inverse_friendships.find_by_user_id(params[:user_id])
    @friendship.destroy
    @inverse_friendship.destroy
    flash[:notice] = "friend deleted"
    redirect_to :back
  end

  def confirm
    @confirm_friendship = current_user.inverse_friendships.find_by_user_id(params[:friend_id])
    @confirm_friendship.confirm = true
    @confirm_friendship.save
    @friendship = current_user.friendships.create!(:friend_id => params[:friend_id])
    @friendship.confirm = true
    @friendship.save
    flash[:notice] = "friend confirmed"
    redirect_to :back
  end

end
