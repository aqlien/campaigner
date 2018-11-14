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
    @emails = User.find(@raw_user_ids).pluck(:email)
    respond_to do |format|
      format.html {render template: 'filters/emails'}
      format.js {render template: 'filters/emails'}
    end
  end

  def select_tag
    respond_to do |format|
      format.html {render template: 'filters/select_tag'}
      format.js {render template: 'filters/select_tag'}
    end
  end

  def apply_tag
    @raw_tag_ids = process_ids(ids: params[:user_tags][:tag_ids], no_overwrite: true)
    # https://joinhandshake.com/engineering/2016/01/26/quickly-inserting-thousands-of-records-in-rails.html
    ids = @raw_user_ids.collect{|user_id| @raw_tag_ids.collect{|tag_id| [user_id, tag_id]}}.flatten(1)
    existing_ids = User.joins(:tags).pluck(:user_id, :tag_id)
    ids -= existing_ids
    values = ids.map{|user_id, tag_id| "(#{user_id},#{tag_id})" }.join(',')
    sql = "INSERT INTO tags_users (user_id,tag_id) VALUES #{values}"
    ActiveRecord::Base.connection.execute(sql) unless values.blank?

    redirect_to filters_path
  end

  helper_method :filter_params

private
  def process_ids(options = {})
    ids = options[:ids] || params[:user_ids] || params[:selected_ids]
    do_not_overwrite_raw_user_variable = options[:no_overwrite] || false
    if ids.blank?
      output_ids = []
    else
      if ids.is_a? String
        ids = ids.split(/\W/)
      end
      output_ids = ids.reject(&:blank?).map(&:to_i)
    end
    @raw_user_ids = output_ids unless do_not_overwrite_raw_user_variable
    output_ids
  end

  def filter_params
    params[:filters] ? params.permit(filters: [:active, :contactable, :no_org])[:filters].transform_values{|v| v!='0' && v!=0} : {active: true, contactable: true, no_org: true}
  end
end
