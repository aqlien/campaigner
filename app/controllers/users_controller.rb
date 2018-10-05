class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :create] #Will need this to register

  def index
    @users = User.all.order(created_at: :asc)
    authorize @users
  end

  def show
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  def edit
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user
    respond_to do |format|
      if @user.save
        sign_in @user unless current_user.present?
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @user
    # Clear password if user is not changing it
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html do
          notice_text = "#{current_user.admin? ? 'User was' : 'Profile'} successfully updated."
          if (current_user && !current_user.admin? && current_survey)
            if ResponseSet.exists?(survey_id: current_survey.id, user_id: current_user.id)
              redirect_to edit_my_survey_path(current_survey.access_code, ResponseSet.find_by(survey_id: current_survey.id, user_id: current_user.id).access_code), notice: notice_text
            else
              rs = ResponseSet.create(survey_id: current_survey.id, user_id: current_user.id)
              redirect_to edit_my_survey_path(current_survey.access_code, rs.access_code), notice: notice_text
            end
          else
            redirect_to @user, notice: notice_text
          end
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :short_name, :pronoun, :pronoun_custom,
        :active, :admin, :organization_id, interest_ids: [], tag_ids: [],
        organization_attributes: [:id, :name, :short_name, :url, :_destroy, :category_ids],
        interest_attributes: [:id, :text, :short_text, :_destroy],
        tag_attributes: [:id, :text, :short_text, :_destroy]).tap do |p|
        p[:interest_ids] = params[:interest_ids].reject(&:blank?) if params[:interest_ids]
        p[:tag_ids] = pparams[:tag_ids].reject(&:blank?) if params[:tag_ids]
        p[:pronoun] = p[:pronoun_custom].downcase unless p[:pronoun_custom].blank?
      end
    end
end
