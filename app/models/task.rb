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
  has_many :labels, through: :tags, dependent: :destroy

  has_many :attachments
  has_one  :schedule

  validates_associated :assignments
  validates :name, :description, presence: true
  validates :name, length: { minimum: 5 }
  validates :description, length: { minimum: 10 }
  validates :name, uniqueness: true
  validates :parent_id, numericality: { only_integer: true }
  validates_inclusion_of :state, :in => [true, false]

  scope :find_tasks, ->(query) { where('name like ?', "%#{query}%") }

end