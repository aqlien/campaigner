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
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :short_name, :pronoun, :active, :admin, :organization_id, :pronoun_custom).tap do |p|
        p[:pronoun] = p[:pronoun_custom].downcase unless p[:pronoun_custom].blank?
      end
    end
end
