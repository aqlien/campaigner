require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(email: "sample#{User.count+1}@test.com"),
      User.create!(email: "sample#{User.count+1}@test.com")
    ])

    allow(view).to receive(:policy) do |record|
      Pundit.policy(User.find_or_create_by(email: 'admin@test.com', admin: true), record)
    end
  end

  it "renders a list of users" do
    render
  end
end
