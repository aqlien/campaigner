class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      # Context
      t.integer :question_id

      # Content
      t.text :text
      t.text :short_text #Used for presenting responses to experts (ie non-survey takers). Just a shorted version of the string
      t.text :help_text
      t.integer :weight # Used to assign a weight to an answer object (used for computing surveys that have numerical results)
      t.string :response_class # What kind of additional data does this answer accept?
      t.string :default_value

      t.string :input_mask
      t.string :input_mask_placeholder

      # Reference
      t.string :reference_identifier
      t.string :data_export_identifier
      t.string :common_namespace
      t.string :common_identifier
      t.string :api_id, index: {unique: true}

      # Display
      t.integer :display_order
      t.boolean :is_exclusive # If set it causes some UI trigger to remove (and disable) all the other answer choices selected for a question
      t.boolean :hide_label
      t.integer :display_length # if smaller than answer length the HTML input length will be this value

      t.string :display_type
      t.string :custom_class
      t.string :custom_renderer

      t.timestamps
    end
  end
end
