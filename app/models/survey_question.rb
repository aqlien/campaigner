class SurveyQuestion < ApplicationRecord

  belongs_to :survey
  has_many :survey_choices

  accepts_nested_attributes_for :survey_choices

  validates :survey, presence: true
  validates :text, presence: true
end
