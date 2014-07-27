class User < ActiveRecord::Base
  has_many :assignments
  has_many :tasks, through: :assignments
end
