class LabelsController < ApplicationController

	def index
		@labels = Label.all
	end

	def show
    @label = Label.find( params[:id] )
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
    @label = Label.find( params[:id] )
	end

	def update
    @label = Label.find( params[:id] )
    if @label.update(params.require(:label).permit(:name))
      redirect_to labels_path
    else
      render :edit
    end
	end

	def destroy
    @label = Label.find( params[:id] )
		@label.destroy
		redirect_to labels_path
	end

end