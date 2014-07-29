# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  task_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Assignment do
  it "has a valid factory" do
    expect(FactoryGirl.build(:assignment)).to be_valid
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:task) }
end
