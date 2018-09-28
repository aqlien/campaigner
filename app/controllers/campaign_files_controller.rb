class CampaignFilesController < ApplicationController
  before_action :set_file, only: [:show, :edit, :update, :destroy]

  def index
    @campaign_files = CampaignFile.all
    authorize @campaign_files
  end

  def show
    authorize @campaign_file
  end

  def new
    @campaign_file = CampaignFile.new
    authorize @campaign_file
  end

  def edit
    authorize @campaign_file
  end

  def create
    @campaign_file = CampaignFile.new(file_params)
    authorize @campaign_file
    respond_to do |format|
      if @campaign_file.save
        format.html { redirect_to @campaign_file, notice: 'File was successfully created.' }
        format.json { render :show, status: :created, location: @campaign_file }
      else
        format.html { render :new }
        format.json { render json: @campaign_file.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @campaign_file
    respond_to do |format|
      if @campaign_file.update(file_params)
        format.html { redirect_to @campaign_file, notice: 'File was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign_file }
      else
        format.html { render :edit }
        format.json { render json: @campaign_file.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @campaign_file
    @campaign_file.destroy
    respond_to do |format|
      format.html { redirect_to files_url, notice: 'File was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_file
      @campaign_file = CampaignFile.find(params[:id])
    end

    def file_params
      params.require(:campaign_file).permit(:name, :file)
    end
end
