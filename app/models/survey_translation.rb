class SurveyTranslation < ApplicationRecord
  belongs_to :survey

  validates_presence_of :locale, :translation
  validates_uniqueness_of :locale, scope: :survey_id

  def initialize(*args)
    super(*args)
    default_args
  end

  def default_args
  end
end
