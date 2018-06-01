class CreateSurveySections < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_sections do |t|
      t.integer :survey_id
      # Content
      t.string :title
      t.text :description
      # Reference
      t.string :reference_identifier
      t.string :data_export_identifier
      t.string :common_namespace
      t.string :common_identifier
      # Display
      t.string :custom_class
      t.integer :display_order

      t.timestamps
    end
  end
end
