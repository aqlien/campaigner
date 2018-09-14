class Interest < ApplicationRecord

  has_and_belongs_to_many :users, inverse_of: :interests
  validates :text, presence: true

  def short_text
    if super.blank?
      text.gsub(/[^a-zA-Z0-9]/,'').gsub(' ', '_').underscore
    end
  end

end
