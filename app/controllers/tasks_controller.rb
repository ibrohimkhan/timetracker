class TasksController < ApplicationController

  layout 'dashboard'
  before_filter :find_user_tasks, :only => [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.page(params[:page]).per_page(3)
    @tasks = @tasks.search(params[:search]) if params[:search]
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params.require(:task).permit(:name, :description))
    @assignment = Assignment.new
    @assignment.user = current_user
    @assignment.task = @task

    if @task.save && @assignment.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(params.require(:task).permit(:name, :description))
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @assignment = Assignment.find_by( task: @task, user: current_user )

    @assignment.destroy
    @task.destroy
    redirect_to tasks_path
  end

  private
  def find_user_tasks
    @task = current_user.tasks.find(params[:id])
  end

end