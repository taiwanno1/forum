class UserProfilesController < ApplicationController

  before_action :find_user

  def show
    @profile = @user.profile
  end

  def new
    @profile = @user.build_profile
  end

  def create
    @profile = @user.build_profile( profile_params )
    if @profile.save
      redirect_to user_profile_url( @user )
    else
      render :action => :new
    end
  end

  def edit
    @profile = @user.profile
  end

  def update
    @profile = @user.profile

    if @profile.update( profile_params )
      redirect_to user_profile_url( @user )
    else
      render :action => :edit
    end

  end

  def destroy
    @profile = @user.profile
    @profile.destroy

    redirect_to user_profile_url( @user )
  end

  protected

  def find_user
    @user = User.find( params[:user_id] )
  end

  def profile_params
    params.require(:profile).permit(:name)
  end

end
