class TasksController < ApplicationController

  layout 'dashboard'

  def index
    @tasks = current_user.tasks.page(params[:page]).per_page(3)
    @tasks = @tasks.search(params[:search]) if params[:search]
  end

  def show
    @task = current_user.tasks.find( params[:id] )
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
    @task = current_user.tasks.find( params[:id] )
  end

  def update
    @task = current_user.tasks.find( params[:id] )
    if @task.update(params.require(:task).permit(:name, :description))
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find( params[:id] )
    @assignment = Assignment.find_by( task: @task, user: current_user )

    @assignment.destroy
    @task.destroy
    redirect_to tasks_path
  end


  private
    def navigation

    end

    def counts

    end
end
