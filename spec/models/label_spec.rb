require 'spec_helper'

describe Label do
  it "has a valid factory" do
    expect(FactoryGirl.build(:label)).to be_valid
  end

  it { is_expected.to have_many(:tags) }
  it { is_expected.to have_many(:tasks).through(:tags) }

end