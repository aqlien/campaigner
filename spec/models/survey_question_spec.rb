require 'rails_helper'

RSpec.describe SurveyQuestion, type: :model do
  it { expect(SurveyQuestion.new(text: nil).valid?).to be false }
end
