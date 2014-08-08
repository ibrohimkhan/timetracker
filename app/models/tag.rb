# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  task_id    :integer
#  label_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  belongs_to :task
  belongs_to :label

  validates_associated :task
  validates_associated :label
end
