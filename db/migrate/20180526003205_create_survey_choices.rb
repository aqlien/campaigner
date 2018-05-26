class CreateSurveyChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_choices do |t|
      t.belongs_to :survey_question, foreign_key: true
      t.integer :raw_value
      t.text :text_output

      t.timestamps
    end
  end
end
