class Survey < ApplicationRecord

  belongs_to :event
  has_many :survey_questions

  validates :event, presence: true
end
