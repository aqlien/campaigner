class CreateCampaignFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_files do |t|
      t.string :name
      t.attachment :file
    end
  end
end
