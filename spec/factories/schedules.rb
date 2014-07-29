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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    association :task
    start_date "2014-07-20"
    end_date "2014-07-27"
  end
end
