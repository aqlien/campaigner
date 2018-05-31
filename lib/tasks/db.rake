namespace :db do
  desc "Copy the heroku staging database to the local development environment"
  task :staging_to_local do
    config = YAML::load(IO.read(Rails.root.join('config', 'database.yml')))[Rails.env]
    puts "Capturing new backup..."
    %x{heroku pg:backups capture} #capture a new backup if scheduled backups are not frequent enough
    newest_backup_name = %x{heroku pg:backups | awk '{print $1 }' | head -n 4 | tail -n 1}.chomp
    puts "New backup name: #{newest_backup_name}"
    url = %x{heroku pg:backups public-url #{newest_backup_name}}
    puts "DB URL: #{url}"
    puts %x{curl '#{url}' | pg_restore --verbose --clean --no-acl --no-owner -h localhost -U #{config["username"]} -d #{config["database"]}}
    puts "Database restoration complete."
  end
end
