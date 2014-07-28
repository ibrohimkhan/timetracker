require 'carrierwave/orm/activerecord'

class Attachment < ActiveRecord::Base
  belongs_to :task
  mount_uploader :file_path, FileUploader
end
