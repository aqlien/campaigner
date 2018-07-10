class FiltersController < ApplicationController

  def index
    @users = User.all.active.where(admin: false)
    @current_events = Event.where("leadup_date <= :start_before AND followup_date >= :end_after", start_before: Date.today, end_after: Date.today)
  end

end
