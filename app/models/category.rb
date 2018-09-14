class Category < ApplicationRecord

  has_and_belongs_to_many :organizations, optional: true, inverse_of: :categories

  validates :name, presence: true
end
