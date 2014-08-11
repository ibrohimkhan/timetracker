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

class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :assignments
  has_many :tasks, through: :assignments

  validates_associated :assignments
  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :password, length: { minimum: 5 }
  validates :password, confirmation: true
  validates :email, uniqueness: true
  validates :email, format: { with: /.+@.+\..+/i,
    message: "only allows letters" }

  def send_reset_password_instructions
    self.reset_password!('test1234', 'test1234')
    Notifier.reset_password_instructions(self).deliver
  end
end