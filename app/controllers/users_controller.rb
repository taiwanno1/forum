class UsersController < ApplicationController

  before_action :find_user

  def show
  end

private

  def user_params
    params.require(:user).permit(:about_user)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
