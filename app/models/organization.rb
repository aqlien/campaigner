class Organization < ApplicationRecord

  has_many :users

  validates :name, presence: true

  def display_name
    if short_name.present?
      name + ' (' + short_name + ')'
    else
      name
    end
  end

end
