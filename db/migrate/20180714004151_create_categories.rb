class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end

    create_join_table :organizations, :categories do |t|
      t.index :organization_id
      t.index :category_id
    end
  end
end
