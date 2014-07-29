# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  task_id    :integer
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Schedule < ActiveRecord::Base
  belongs_to :task
end
