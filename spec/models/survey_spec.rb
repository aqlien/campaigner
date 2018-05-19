require 'rails_helper'

RSpec.describe Survey, type: :model do
  it { expect(Survey.new(event: nil).valid?).to be false }
  it { expect(Survey.new(event: Event.new(), user: User.new()).valid?).to be true }
end
