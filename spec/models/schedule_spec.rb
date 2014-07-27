require 'spec_helper'

describe Schedule do
  it "has a valid factory" do
    expect(FactoryGirl.build(:schedule)).to be_valid
  end

  it { is_expected.to belong_to(:task) }
end