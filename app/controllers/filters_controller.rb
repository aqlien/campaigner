class FiltersController < ApplicationController
  before_action :process_ids, except: :index

  def index
    @users = User.all.active.where(admin: nil)
    @current_events ||= Event.where("leadup_date <= :start_before AND followup_date >= :end_after", start_before: Date.today, end_after: Date.today)
    @current_survey ||= Survey.where(event_id: @current_events.pluck(:id)).take
    if @current_survey
      @response_sets = ResponseSet.joins(:responses).where(user_id: @users.pluck(:id), survey_id: @current_survey.id)
    else
      render text: "No current events scheduled!"
    end
  end

  def emails
    @raw_user_ids = process_ids(params[:selected_ids]) if @raw_user_ids.empty?
    puts "RAW USER IDS = " + @raw_user_ids.to_s
    @emails = User.find(@raw_user_ids).pluck(:email)
    respond_to do |format|
      format.html {render template: 'filters/emails'}
      format.js {render template: 'filters/emails'}
    end
  end

private
  def process_ids(user_ids = params[:user_ids])
    if user_ids.blank?
      @raw_user_ids = []
    else
      if user_ids.is_a? String
        user_ids = user_ids.split(/\W/)
      end
      @raw_user_ids = user_ids.map!(&:to_i)
    end
  end

end
