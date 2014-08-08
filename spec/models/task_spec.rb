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

require_relative '../spec_helper'

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

	it { is_expected.to validate_presence_of(:name) }
	it { is_expected.to validate_presence_of(:description) }
	it { is_expected.to ensure_length_of(:name).is_at_least(5) }
	it { is_expected.to ensure_length_of(:description).is_at_least(10) }
	it { is_expected.to validate_uniqueness_of(:name) }

end