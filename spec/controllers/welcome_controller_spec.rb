require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  let(:valid_session) { {} }

  describe "GET #index" do
    login_admin
    it "returns a redirect response to the users index" do
      get :index, params: {}, session: valid_session
      expect(response).to redirect_to(users_path)
    end
  end

  describe "GET #index" do
    login_user
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

end
