require "rails_helper"

RSpec.describe SurveysController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/surveys/").to route_to("surveys#new")
    end

    it "routes to #show" do
      expect(:get => "/surveys/survey-name/abc").to route_to("surveys#show", survey_code: "survey-name", response_set_code: 'abc')
    end

    it "routes to #edit" do
      expect(:get => "/surveys/survey-name/abc/take").to route_to("surveys#edit", survey_code: "survey-name", response_set_code: 'abc')
    end

    it "routes to #create" do
      expect(:post => "/surveys/survey-name").to route_to("surveys#create", survey_code: "survey-name")
    end

    it "routes to #update via PUT" do
      expect(:put => "/surveys/survey-name/abc").to route_to("surveys#update", survey_code: "survey-name", response_set_code: 'abc')
    end

    it "routes to #update via PATCH" do
      pending
      expect(:patch => "/surveys/survey-name/abc").to route_to("surveys#update", survey_code: "survey-name", response_set_code: 'abc')
    end

  end
end
