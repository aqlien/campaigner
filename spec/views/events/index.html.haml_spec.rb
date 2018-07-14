require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :name => "Name", start_date: Date.today
      ),
      Event.create!(
        :name => "Name", start_date: Date.today
      )
    ])

    allow(view).to receive(:policy) do |record|
      Pundit.policy(User.find_or_create_by(email: 'admin@test.com', admin: true), record)
    end
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
