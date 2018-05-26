class SurveyChoice < ApplicationRecord

  belongs_to :survey_question
  has_many :survey_choices

  validates :survey_question, presence: true
end
