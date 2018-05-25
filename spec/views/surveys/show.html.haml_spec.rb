require 'rails_helper'

RSpec.describe "surveys/show", type: :view do
  before(:each) do
    @survey = assign(:survey, Survey.create!(
      :event_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/3/)
  end
end
