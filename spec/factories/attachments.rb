# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  task_id    :integer
#  file_path  :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    association :task
    file_path { Faker::Internet.url }
  end
end
