class Category < ApplicationRecord
  
  has_and_belongs_to_many :organizations, optional: true

  validates :name, presence: true
end
