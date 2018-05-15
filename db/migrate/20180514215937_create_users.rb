class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :short_name
      t.string :pronoun
      t.boolean :active, default: true
      t.boolean :admin

      t.timestamps
    end
  end
end
