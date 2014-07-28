# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  task_id    :integer
#  file_path  :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Attachment do
  it "has a valid factory" do
    expect(FactoryGirl.build(:attachment)).to be_valid
  end

  it { is_expected.to belong_to(:task) }
end
