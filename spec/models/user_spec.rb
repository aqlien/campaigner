require 'rails_helper'

RSpec.describe User, type: :model do
  it 'requires an email for new users' do
    expect(User.new(email: nil).valid?).to be false
  end

  it 'does not require a password for new users, so that admins can create them' do
    pending
  end
end
