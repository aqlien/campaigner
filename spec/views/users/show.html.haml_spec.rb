require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(email: "sample#{User.count+1}@test.com"))
  end

  it "renders attributes in <p>" do
    render
  end
end
