require 'spec_helper'

describe Tag do
  it "has a valid factory" do
    expect(FactoryGirl.build(:tag)).to be_valid
  end

  it { is_expected.to belong_to(:task) }
  it { is_expected.to belong_to(:label) }
end