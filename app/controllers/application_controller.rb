class ApplicationController < ActionController::Base
  include Pundit
  layout 'application'
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  helper_method :current_survey

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_events
    @current_events ||= Event.where("leadup_date <= :start_before AND followup_date >= :end_after", start_before: Date.today, end_after: Date.today)
  end

  def current_survey
    @current_survey ||= Survey.where(event_id: current_events.pluck(:id)).order(survey_version: :desc).take
  end

private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
