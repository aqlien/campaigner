class SurveyChoice < ApplicationRecord

  belongs_to :survey_question

  validates :survey_question, presence: true
end
