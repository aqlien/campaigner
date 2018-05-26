require 'rails_helper'

RSpec.describe "surveys/show", type: :view do
  before(:each) do
    @survey = assign(:survey, Survey.create!(
      event: Event.new(name: 'New Event')
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/New Event/)
  end
end
