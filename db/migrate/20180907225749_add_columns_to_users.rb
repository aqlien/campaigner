class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone, :string
    add_column :users, :city, :string
    add_column :users, :notes, :text
  end
end
