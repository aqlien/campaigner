class Survey < ApplicationRecord

  belongs_to :event
  has_many :survey_questions, inverse_of: :survey
  has_many :survey_choices, through: :survey_questions

  accepts_nested_attributes_for :survey_questions, reject_if: :all_blank, allow_destroy: true

  validates :event, presence: true
end
