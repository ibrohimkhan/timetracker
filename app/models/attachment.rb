# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  task_id    :integer
#  file_path  :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'carrierwave/orm/activerecord'

class Attachment < ActiveRecord::Base
  belongs_to :task
  mount_uploader :file_path, FileUploader

  validates_associated :task
  validates_presence_of :task_id
end
