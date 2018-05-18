require 'rails_helper'

RSpec.describe Event, type: :model do
  it { expect(Event.new(name: nil).valid?).to be false }
end
