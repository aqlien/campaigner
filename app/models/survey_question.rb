class SurveyQuestion < ApplicationRecord

  belongs_to :survey
  has_many :survey_choices, inverse_of: :survey_question

  accepts_nested_attributes_for :survey_choices, reject_if: :all_blank, allow_destroy: true

  validates :survey, presence: true
  validates :text, presence: true
end
