require 'rails_helper'

RSpec.describe "surveys/edit", type: :view do
  before(:each) do
    @survey = assign(:survey, Survey.create!(
      :user_id => 1,
      :event_id => 1
    ))
  end

  it "renders the edit survey form" do
    render

    assert_select "form[action=?][method=?]", survey_path(@survey), "post" do

      assert_select "select#survey_user_id[name=?]", "survey[user_id]"

      assert_select "select#survey_event_id[name=?]", "survey[event_id]"
    end
  end
end
