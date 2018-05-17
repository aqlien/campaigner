require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { expect(Organization.new(name: nil).valid?).to be false }
end
