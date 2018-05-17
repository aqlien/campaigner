class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end

    add_column :users, :organization_id, :integer

    add_index :organizations, :name
    add_index :organizations, :short_name
  end
end
