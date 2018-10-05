class WelcomeController < ApplicationController
  def index
    if current_user && current_user.admin?
      redirect_to users_path
    elsif current_user
      redirect_to edit_user_path(current_user)
    end
  end
end
