class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.string :type
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end

    add_index :surveys, :user_id
    add_index :surveys, :event_id
  end
end
