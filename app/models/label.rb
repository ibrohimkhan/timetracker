class Label < ActiveRecord::Base
  has_many :tags
  has_many :tasks, through: :tags
end
