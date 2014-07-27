class Tag < ActiveRecord::Base
  belongs_to :task
  belongs_to :label
end
