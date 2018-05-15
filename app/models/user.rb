class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness: true, email_format: true, if: (:email_changed? || :new_record?)
  validates :password, presence: true, confirmation: true, length: { within: 8..128 }, if: :password_required?
  validates :password_confirmation, presence: true, unless: :new_record?

private
  # Only used for validations. Overrides Devise's 'password_required?' method.
  # Passwords should not be needed for new records.
  def password_required?
    new_record? ? false : super
  end

end
