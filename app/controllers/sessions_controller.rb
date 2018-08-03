class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    if current_user
      redirect_to "/profile"
    else
      render :new
    end
  end

  def create
    @user = User.find_by({ name: params[:name] })

    if !!@user && @user.authenticate(params[:password])
      session[:logged_in_user_id] = @user.id
      flash[:notice] = "Login Successful!"
      redirect_to profile_path
    else
      flash[:notice] = "Invalid username or password"
      redirect_to new_session_path
    end
  end

  def destroy
    session.delete(:logged_in_user_id)
    flash[:notice] = "Logout successful"
    redirect_to new_session_path
  end
end
