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

require 'spec_helper'

describe Schedule do
  it "has a valid factory" do
    expect(FactoryGirl.build(:schedule)).to be_valid
  end

  it { is_expected.to belong_to(:task) }
end
