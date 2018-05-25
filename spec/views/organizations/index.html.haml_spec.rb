require 'rails_helper'

RSpec.describe "organizations/index", type: :view do
  before(:each) do
    assign(:organizations, [
      Organization.create!(
        :name => "Name",
        :short_name => "Short Name"
      ),
      Organization.create!(
        :name => "Name",
        :short_name => "Short Name"
      )
    ])

    allow(view).to receive(:policy) do |record|
      Pundit.policy(User.find_or_create_by(email: 'admin@test.com', admin: true), record)
    end
  end

  it "renders a list of organizations" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Short Name".to_s, :count => 2
  end
end
