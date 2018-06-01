class CreateDependencies < ActiveRecord::Migration[5.0]
  def change
    create_table :dependencies do |t|
      # Context
      t.integer :question_id
      t.integer :question_group_id

      # Condition
      t.string :rule

      # Result - TODO: figure out the dependency hook presentation options
      # t.string :property_to_toggle # visibility, class_name
      # t.string :effect # blind, opacity

      t.timestamps
    end
  end
end
