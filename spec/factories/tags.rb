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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    association :task
    association :label
  end
end
