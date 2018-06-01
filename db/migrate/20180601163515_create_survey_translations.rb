class CreateSurveyTranslations < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_translations do |t|
      # Content
      t.integer :survey_id
      # Reference
      t.string :locale
      t.text :translation
      t.timestamps
    end
  end
end
