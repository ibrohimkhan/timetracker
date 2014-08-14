class TasksController < ApplicationController

  layout 'dashboard'
  before_filter :find_user_tasks, :only => [:show, :edit, :update, :destroy]

  def index
    current = current_user.tasks
    @tasks = current.parent_task.page(params[:page]).per_page(3)
    @tasks = current.find_tasks(params[:search]).page(params[:page]).per_page(3) if params[:search]
  end

  def show
    @children = current_user.tasks.where('parent_id = ?', params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params.require(:task).permit(:name, :description))
    @assignment = Assignment.new
    @assignment.user = current_user
    @assignment.task = @task

    label_name = Rails.cache.read("label")
    save(@task, label_name) unless label_name.nil?

    return redirect_to task_path(@task) if @task.save && @assignment.save
    render :new
  end

  def edit
  end

  def update
    return redirect_to tasks_path if @task.update(params.require(:task).permit(:name, :description, :parent_id))
    render :edit
  end

  def destroy
    @assignment = Assignment.find_by(task: @task, user: current_user)
    @assignment.destroy
    @task.destroy
    redirect_to tasks_path
  end

  def save_labels
    labels = params[:label]
    Rails.cache.delete("label")
    Rails.cache.write("label", labels[:name])
  end

  def save_by_task_id
    labels = params[:label]
    task = current_user.tasks.find(labels[:id])
    save(task, labels[:name])
  end

  def delete_label
    labels = params[:label]
    task = current_user.tasks.find((labels[:id]).to_i)
    label_id = task.labels.where("name = ?", labels[:name]).ids

    tag_id = Tag.where("task_id = ? and label_id = ?", task.id, label_id).ids
    Tag.destroy(tag_id)
    Task.children(@task.id).delete_all
  end

  private
  def find_user_tasks
    @task = current_user.tasks.find(params[:id])
  end

  def save(task, label_name)
    label_name.split('/*/').each do |name|
      @tag = Tag.new
      @tag.task = task
      @tag.label = Label.find_by_name(name)
      @tag.save
    end
  end

end