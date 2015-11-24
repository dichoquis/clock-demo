class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email])
    if user && user.authenticate(params[:sessions][:password])
      sign_in user
      session[:user_id] = user.id
      redirect_to users_path
    else
      flash.now[:danger] = t 'login_errors'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end