# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text
#  parent_id   :integer          default(0)
#  state       :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

class Task < ActiveRecord::Base
  has_many :assignments
  has_many :users, through: :assignments
  has_many :tags
  has_many :labels, through: :tags

  has_many :attachments
  has_one  :schedule

  scope :find_tasks, ->(query) { where('name like ?', "%#{query}%") }

end
