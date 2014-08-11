class NotifierPreview < ActionMailer::Preview
  def reset_password_instructions
    user = FactoryGirl.build(:user)
    Notifier.reset_password_instructions(user)
  end
end