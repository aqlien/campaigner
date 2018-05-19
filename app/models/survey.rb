class Survey < ApplicationRecord

  belongs_to :user
  has_one :organization, through: :user
  belongs_to :event

  validates :event, presence: true
  validates :user, presence: true
end
