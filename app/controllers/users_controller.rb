class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def show
    render :show
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      flash[:notice] = "Signup successful! Welcome, #{@user.name}"
      session[:logged_in_user_id] = @user.id
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Successfully updated profile"
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "Deleted account for #{@user.name}"
    redirect_to new_user_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :profile_photo, :avatar, :email)
  end
end
