class LabelsController < ApplicationController

  def create
    @label = Label.new label_param

    respond_to do |format|
      if @label.save
        format.json { render json: @label, status: :created, location: @label }
      else
        @label_item = Label.where("name = ?", label_param[:name])
        format.json { render json: @label_item }
      end
    end
  end

  private
  def label_param
    params.require(:label).permit(:name)
  end
end
