require 'rails_helper'

RSpec.describe SurveyChoice, type: :model do
  it { expect(SurveyChoice.new(survey_question: nil).valid?).to be false }
end
