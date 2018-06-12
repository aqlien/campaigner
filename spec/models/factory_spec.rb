require 'rails_helper'

RSpec.describe 'FactoryGirl test' do
  it { expect(FactoryGirl.create(:event).valid?).to be true }
  it { expect(FactoryGirl.create(:user).valid?).to be true }

  it { expect(FactoryGirl.create(:survey).valid?).to be true }
  it { expect(FactoryGirl.create(:survey_section).valid?).to be true }

  it { expect(FactoryGirl.create(:question_group).valid?).to be true }
  it { expect(FactoryGirl.create(:question).valid?).to be true }
  it { expect(FactoryGirl.create(:dependency).valid?).to be true }
  it { expect(FactoryGirl.create(:dependency_condition).valid?).to be true }
  it { expect(FactoryGirl.create(:answer).valid?).to be true }

  it { expect(FactoryGirl.create(:response_set).valid?).to be true }
  it { expect(FactoryGirl.create(:response).valid?).to be true }

  it { expect(FactoryGirl.create(:validation).valid?).to be true }
  it { expect(FactoryGirl.create(:validation_condition).valid?).to be true }
end
