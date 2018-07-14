class Organization < ApplicationRecord

  has_many :users, dependent: :nullify
  has_and_belongs_to_many :categories

  validates :name, presence: true

  def display_name
    if short_name.present?
      name + ' (' + short_name + ')'
    else
      name
    end
  end

end
