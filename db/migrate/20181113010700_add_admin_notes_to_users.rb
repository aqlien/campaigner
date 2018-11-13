class AddAdminNotesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin_notes, :text
  end
end
