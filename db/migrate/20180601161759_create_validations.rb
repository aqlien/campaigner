class CreateValidations < ActiveRecord::Migration[5.0]
  def change
    create_table :validations do |t|
      # Context
      t.integer :answer_id # the answer to validate
      # Conditional
      t.string :rule
      # Message
      t.string :message
      t.timestamps
    end
  end
end
