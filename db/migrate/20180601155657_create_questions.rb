class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      # Context
      t.integer :survey_section_id
      t.integer :question_group_id

      # Content
      t.text :text
      t.text :short_text # For experts (ie non-survey takers). Short version of text
      t.text :help_text
      t.string :pick
      t.integer :correct_answer_id

      # Reference
      t.string :reference_identifier
      t.string :data_export_identifier
      t.string :common_namespace
      t.string :common_identifier
      t.string :api_id, index: {unique: true}

      # Display
      t.integer :display_order
      t.string :display_type
      t.boolean :is_mandatory
      t.integer :display_width # used only for slider component (if needed)

      t.string :custom_class
      t.string :custom_renderer

      t.timestamps
    end
  end
end
