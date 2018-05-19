require 'rails_helper'

RSpec.describe "surveys/new", type: :view do
  before(:each) do
    assign(:survey, Survey.new(
      :user_id => 1,
      :event_id => 1
    ))
  end

  it "renders new survey form" do
    render

    assert_select "form[action=?][method=?]", surveys_path, "post" do

      assert_select "select#survey_user_id[name=?]", "survey[user_id]"

      assert_select "select#survey_event_id[name=?]", "survey[event_id]"
    end
  end
end
