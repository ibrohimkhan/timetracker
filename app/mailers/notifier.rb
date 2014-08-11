class Notifier < ActionMailer::Base
  default from: ENV['GMAIL_USERNAME']

  def reset_password_instructions(recipient)
    @account = recipient
    mail(to: recipient.email, :subject => "Reset Password Instructions")
  end
end
