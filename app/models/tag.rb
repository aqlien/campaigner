class Tag < ApplicationRecord

  has_and_belongs_to_many :users
  validates :text, presence: true

end
