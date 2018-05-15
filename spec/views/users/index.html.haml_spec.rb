require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(email: "sample#{User.count+1}@test.com"),
      User.create!(email: "sample#{User.count+1}@test.com")
    ])
  end

  it "renders a list of users" do
    render
  end
end
