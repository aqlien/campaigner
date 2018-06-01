class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      # Context
      t.integer :survey_section_id, index: true
      t.integer :response_set_id
      t.integer :question_id

      # Content
      t.integer :answer_id
      t.datetime :datetime_value # handles date, time, and datetime (segregate by answer.response_class)
      t.integer :integer_value
      t.float :float_value
      t.string :unit
      t.text :text_value
      t.string :string_value
      t.string :response_other #used to hold the string entered with "Other" type answers in multiple choice questions

      # arbitrary identifier used to group responses
      # the pertinent example here is Q: What's your car's make/model/year
      # group 1: Ford/Focus/2007
      # group 2: Toyota/Prius/2006
      t.string :response_group

      # Reference
      t.string :api_id, index: {unique: true}

      t.timestamps
    end
  end
end
