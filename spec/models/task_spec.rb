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