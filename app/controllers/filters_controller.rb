class FiltersController < ApplicationController
  before_action :process_ids, except: :index

  respond_to :html, :js, :json

  def index
    @surveys = current_events.present? ? Survey.where(event_id: current_events.pluck(:id)) : Survey.none
    @surveys = Survey.all if Rails.env.development?

    @users = UserFilterSet.new(filters: filter_params)
    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  def emails
    @raw_user_ids = process_ids(params[:selected_ids]) if @raw_user_ids.empty?
    @emails = User.find(@raw_user_ids).pluck(:email)
    respond_to do |format|
      format.html {render template: 'filters/emails'}
      format.js {render template: 'filters/emails'}
    end
  end

  helper_method :filter_params

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

  def filter_params
    params[:filters] ? params.permit(filters: [:active, :contactable, :no_org])[:filters].transform_values{|v| v!='0' && v!=0} : {active: true, contactable: true, no_org: true}
  end

end
