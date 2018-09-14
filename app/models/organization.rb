class Organization < ApplicationRecord

  has_many :users, dependent: :nullify, inverse_of: :organization
  has_and_belongs_to_many :categories, inverse_of: :organizations
  accepts_nested_attributes_for :categories


  validates :name, presence: true

  def display_name
    if short_name.present?
      name + ' (' + short_name + ')'
    else
      name
    end
  end

end
