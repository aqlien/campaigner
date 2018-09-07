class CreateUserInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :interests do |t|
      t.string :text
      t.string :short_text
    end

    create_join_table :users, :interests do |t|
      t.index :user_id
      t.index :interest_id
    end
  end
end
