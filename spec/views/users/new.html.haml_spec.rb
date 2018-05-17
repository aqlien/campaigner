require 'rails_helper'


RSpec.describe "users/new", type: :view do
  include Devise::Test::ControllerHelpers
  before(:each) do
    assign(:user, User.new(email: "sample#{User.count+1}@test.com"))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do
    end
  end
end
