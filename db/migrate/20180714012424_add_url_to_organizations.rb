class AddUrlToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :url, :string
  end
end
