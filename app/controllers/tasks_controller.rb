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

    name = Rails.cache.read("label")
    if name.include?('/*/')
      name.split('/*/').each do |label_name|
        @tag = Tag.new
        @tag.task = @task
        @tag.label = Label.find_by_name(label_name)
        @tag.save
      end
    else
      @tag = Tag.new
      @tag.task = @task
      @tag.label = Label.find_by_name(name)
      @tag.save
    end

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

  def set_labels
    labels = params[:label]
    Rails.cache.write("label", labels[:name])
  end

  private
  def find_user_tasks
    @task = current_user.tasks.find(params[:id])
  end

end