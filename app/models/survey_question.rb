class SurveyQuestion < ApplicationRecord

  belongs_to :survey

  validates :survey, presence: true
  validates :text, presence: true
end
