class CreateResponseSets < ActiveRecord::Migration[5.0]
  def change
    create_table :response_sets do |t|
      # Context
      t.integer :user_id
      t.integer :survey_id

      # Content
      t.string :access_code, index: {unique: true}

      # Reference
      t.string :api_id, index: {unique: true}

      # Expiry
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
