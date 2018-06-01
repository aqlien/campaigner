class CreateQuestionGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :question_groups do |t|
      # Content
      t.text :text
      t.text :help_text
      # Reference
      t.string :reference_identifier
      t.string :data_export_identifier
      t.string :common_namespace
      t.string :common_identifier
      t.string :api_id, index: {unique: true}
      # Display
      t.string :display_type

      t.string :custom_class
      t.string :custom_renderer

      t.timestamps
    end
  end
end
