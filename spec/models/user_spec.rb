# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#

require_relative "../spec_helper"

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it { is_expected.to have_many(:assignments) }
  it { is_expected.to have_many(:tasks).through(:assignments) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:password_confirmation) }
  it { is_expected.to ensure_length_of(:first_name).is_at_least(2) }
  it { is_expected.to ensure_length_of(:last_name).is_at_least(2) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to allow_value('/.+@.+\..+/i').for(:email )}

end

