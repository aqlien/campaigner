class Survey < ApplicationRecord

  belongs_to :event
  has_many :survey_questions
  has_many :survey_choices, through: :survey_questions

  accepts_nested_attributes_for :survey_questions

  validates :event, presence: true
end
