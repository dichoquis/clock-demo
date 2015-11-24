class UsersController < ApplicationController
  layout 'admin'
  before_action :require_user

  rescue_from ActiveRecord::RecordNotFound, :with => :user_not_found

  def index
    @active_users = User.where(status: 0)
    @archived_users = User.where(status: 1)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = t 'users.messages.saved'
      redirect_to users_path
    else
      flash.now[:danger] = t 'users.form.messages.invalid'
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = t 'users.messages.updated'
      redirect_to users_path
    else
      flash.now[:danger] = t 'users.form.messages.invalid'
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = t 'users.messages.deleted'
    redirect_to users_path
  end

  def active
    user = User.find(params[:id])
    if user != nil
      user.status = 'active'
      user.archived_date = nil
      user.save
      flash[:notice] = t 'users.messages.actived'
    end
    redirect_to users_path
  end

  def archive
    user = User.find(params[:id])
    if user != nil
      user.status = 'archived'
      user.archived_date = DateTime.now
      user.save
      flash[:notice] = t 'users.messages.archived'
    end
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :role, :timezone, :first_name, :last_name, :email, :phone_number, :title)
    end

    def user_not_found
      flash[:error] = t 'users.errors.not_found'
      redirect_to users_path
    end
end
