class WelcomeController < ApplicationController
  def index
    if current_user && current_user.admin?
      redirect_to users_path
    end
  end
end
