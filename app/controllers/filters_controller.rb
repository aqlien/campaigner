class FiltersController < ApplicationController

  def index
    @users = User.all.active.where(admin: false)
    @current_events ||= Event.where("leadup_date <= :start_before AND followup_date >= :end_after", start_before: Date.today, end_after: Date.today)
    @current_survey ||= Survey.where(event_id: @current_events.pluck(:id)).take
    if @current_survey
      @response_sets = ResponseSet.joins(:responses).where(user_id: @users.pluck(:id), survey_id: @current_survey.id)
    else
      render text: "No current events scheduled!"
    end
  end

end
