class UserProfilesController < ApplicationController

  before_action :find_user

  def index
    @profile = @user.profile
  end

  def show
    @profile = @user.profile
  end

  def new
    @profile = @user.build_profile
  end

  def create
    @profile = @user.build_profile( profile_params )
    if @profile.save
      render :action => :show
    else
      render :action => :new
    end
  end

  def edit
    @profile = @user.profile
    if @user.profile
      @user.profile
    else
      @user.get_profile
    end

  end

  def update
    @profile = @user.profile

    if @profile.update( profile_params )
      render :action => :show
    else
      redirect_to back
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
    params.require(:profile).permit(:name, :about)
  end

end
