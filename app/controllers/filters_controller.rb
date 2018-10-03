class FiltersController < ApplicationController
  before_action :process_ids, except: :index

  respond_to :html, :js, :json

  def index
    @surveys = Survey.none

    @users = UserFilterSet.new(filters: {active: true})
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
