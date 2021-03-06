class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization, optional: true
  has_many :response_sets

  has_and_belongs_to_many :tags, optional: true, inverse_of: :users
  has_and_belongs_to_many :interests, optional: true, inverse_of: :users

  accepts_nested_attributes_for :tags, reject_if: proc { |attributes| attributes[:text].blank? }
  accepts_nested_attributes_for :interests, reject_if: proc { |attributes| attributes[:text].blank? }

  validates :email, presence: true, email_format: true, if: (:email_changed? || :new_record?)
    # uniqueness: true (already checked by Devise)
  validates :password, presence: true, confirmation: true, length: { within: 6..128 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  scope :active, -> { where(active: true) }
  scope :admin,  -> { where(admin: true) }

  attr_accessor :pronoun_custom #only used during user creation/update, if setting custom pronouns

  def self.secure_password
    secure_password = ''
    while !valid_password?(secure_password)
      secure_password = SecureRandom.base64(10).gsub(/=+$/,'')
    end
    secure_password
  end

  def self.valid_password?(password)
    password.match(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/) && password.length >= 6
  end

  def display_phone
    if phone.present? && phone.chomp =~ /^(\d{3})(\d{3})(\d{4})$/
      return "(#{$1})#{$2}-#{$3}"
    else
      phone
    end
  end

private
  # Only used for validations. Overrides Devise's 'password_required?' method.
  # Passwords should not be needed for new records.
  def password_required?
    new_record? ? false : super
  end

end
