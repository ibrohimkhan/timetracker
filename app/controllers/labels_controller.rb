class LabelsController < ApplicationController

  before_filter :find_label, :only => [:show, :edit, :update, :destroy]

	def index
		@labels = Label.all
	end

	def show
	end

	def new
		@label = Label.new
	end

	def create
    @label = Label.new(params.require(:label).permit(:name))
		if @label.save
			redirect_to labels_path
		else
			render :new
		end
	end

	def edit
	end

	def update
    if @label.update(params.require(:label).permit(:name))
      redirect_to labels_path
    else
      render :edit
    end
	end

	def destroy
		@label.destroy
		redirect_to labels_path
	end

  private
  def find_label
    @label = Label.find(params[:id])
  end

end
