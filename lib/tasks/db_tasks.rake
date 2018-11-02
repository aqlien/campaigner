namespace :db do

  desc "Copy the production database to staging"
  task :production_to_staging do
    production_appname = 'womxn-march'
    staging_appname = 'womxn-march-dev'
    newest_backup_name = %x{heroku pg:backups --app #{production_appname} | awk '{print $1 }' | head -n 4 | tail -n 1}.chomp
    url = %x{heroku pg:backups public-url #{newest_backup_name} --app #{production_appname}}.chomp
    puts "Production url: #{url}\n"
    puts %x{heroku pg:backups restore '#{url}' DATABASE --confirm #{staging_appname} --app #{staging_appname}}
    puts "\n\nData copied from production.\n\n"
  end

  desc "Copy the production database to localhost"
  task :production_to_local do
    production_appname = 'womxn-march'
    config = YAML::load(IO.read(Rails.root.join("config","database.yml")))[Rails.env]
    newest_backup_name = %x{heroku pg:backups --app #{production_appname} | awk '{print $1 }' | head -n 4 | tail -n 1}.chomp
    url = %x{heroku pg:backups public-url #{newest_backup_name} --app #{production_appname}}.chomp
    puts "Production url: #{url}"
    puts %x{curl '#{url}' | pg_restore --verbose --clean --no-acl --no-owner --host=localhost --username=#{config["username"]} --dbname=#{config["database"]}}
    puts "\n\nData restored from production.\n\n"
  end

end
