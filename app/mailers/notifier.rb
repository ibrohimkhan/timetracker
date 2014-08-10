class Notifier < ActionMailer::Base
  #include Devise::Mailers::Helpers
  default from: ENV['GMAIL_USERNAME']

  def reset_password_instructions(recipient)
    @account = recipient
    mail(to: recipient.email, :subject => "Reset Password Instructions")
  end
end
