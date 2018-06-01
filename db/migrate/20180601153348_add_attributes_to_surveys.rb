class AddAttributesToSurveys < ActiveRecord::Migration[5.0]
  def change
    # Content
    add_column :surveys, :title, :string
    add_column :surveys, :description, :text
    # Reference
    add_column :surveys, :access_code, :string
    add_column :surveys, :reference_identifier, :string # from paper
    add_column :surveys, :data_export_identifier, :string # data export
    add_column :surveys, :common_namespace, :string # maping to a common vocab
    add_column :surveys, :common_identifier, :string # maping to a common vocab
    add_column :surveys, :survey_version, :integer, :default => 0 # version number
    add_column :surveys, :api_id, :string
    # Expiry
    add_column :surveys, :active_at, :datetime
    add_column :surveys, :inactive_at, :datetime
    # Display
    add_column :surveys, :css_url, :string
    add_column :surveys, :custom_class, :string
    add_column :surveys, :display_order, :integer

    # Index surveys by access code
    add_index :surveys, [:access_code, :survey_version], name: 'surveys_access_code_version_idx', unique: true
    add_index :surveys, :api_id, unique: true
  end
end
