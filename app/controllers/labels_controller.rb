class LabelsController < ApplicationController

	before_filter :find_label, only: [:show, :edit, :update, :destroy]

	def index
		@labels = Label.all
	end

	def show
	end

	def new
		@label = Label.new
	end

	def create
		@label = Label.create(label_params)
		if @label.errors.empty?
			redirect_to @label
		else
			render :new
		end
	end

	def edit
	end

	def update
		@label.update_attributes(label_params)
		if @label.errors.empty?
			redirect_to @label
		else
			render :edit
		end
	end

	def destroy
		@label.destroy
		redirect_to items_path
	end

	private

		def label_params
			params.require(:label).permit!
		end

		def find_label
			@label = Label.find(params[:id])
		end

end
