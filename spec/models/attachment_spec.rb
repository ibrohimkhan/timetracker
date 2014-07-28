require 'spec_helper'

describe Attachment do
  it "has a valid factory" do
    expect(FactoryGirl.build(:attachment)).to be_valid
  end

  it { is_expected.to belong_to(:task) }
end