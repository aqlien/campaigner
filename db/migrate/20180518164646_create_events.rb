class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :leadup_date
      t.datetime :followup_date

      t.timestamps
    end
  end
end
