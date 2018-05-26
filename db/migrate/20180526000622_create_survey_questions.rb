class CreateSurveyQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_questions do |t|
      t.belongs_to :survey, foreign_key: true
      t.text :text
      t.integer :order
      t.string :question_type

      t.timestamps
    end
  end
end
