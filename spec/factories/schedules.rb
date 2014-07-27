# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    task nil
    start_date "2014-07-27"
    end_date "2014-07-27"
  end
end
