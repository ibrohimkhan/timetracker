# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text
#  parent_id   :integer          default(0)
#  state       :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Task do
  it "has a valid factory" do
    expect(FactoryGirl.build(:task)).to be_valid
  end

  it { is_expected.to have_many(:assignments) }
  it { is_expected.to have_many(:users).through(:assignments) }

  it { is_expected.to have_many(:tags) }
  it { is_expected.to have_many(:labels).through(:tags) }

  it { is_expected.to have_many(:attachments) }
  it { is_expected.to have_one(:schedule) }
end
