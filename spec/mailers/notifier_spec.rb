require "spec_helper"

describe Notifier do
  context "email instraction" do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { Notifier.reset_password_instructions(user) }
    let(:address) { ENV['GMAIL_USERNAME'] }

    it 'renders the subject' do
      expect(mail.subject).to eql('Reset Password Instructions')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to include(address)
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(user.first_name)
      expect(mail.body.encoded).to match(user.last_name)
    end
  end
end
