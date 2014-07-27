class Task < ActiveRecord::Base
  has_many :assignments
  has_many :users, through: :assignments
  has_many :tags
  has_many :labels, through: :tags

  has_many :attachments
  has_one :schedule
end
