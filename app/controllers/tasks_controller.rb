class TasksController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all
    @status = %w[todo doing done]
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @status = %w[todo doing done]
  end

  def edit
    redirect_to action: :index unless current_user.id == @task.user_id
  end

  def update
    if @event.update(task_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @task.user_id
      @task.destroy
      redirect_to root_path
    else
      redirect_to action: :index
    end
  end

  private

  def task_params
    params.require(:task).permit(:task_title, :complete).merge(user_id: current_user.id)
  end

  def set_item
    @task = Task.find(params[:id])
  end
end
