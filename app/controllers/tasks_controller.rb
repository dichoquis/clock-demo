class TasksController < ApplicationController
  layout 'admin'
  before_action :require_user

  def index
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id unless current_user.admin?
    if @task.save
      flash[:notice] = t('tasks.messages.saved').html_safe
      redirect_to tasks_path
    else
      flash.now[:danger] = t('tasks.form.messages.invalid').html_safe
      render 'new'
    end
  end

  private

    def task_params
      params.require(:task).permit(:user_id, :description, :priority, :expiration_date)
    end

end
