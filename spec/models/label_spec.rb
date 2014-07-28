# == Schema Information
#
# Table name: labels
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Label do
  it "has a valid factory" do
    expect(FactoryGirl.build(:label)).to be_valid
  end

  it { is_expected.to have_many(:tags) }
  it { is_expected.to have_many(:tasks).through(:tags) }

end
