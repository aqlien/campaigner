namespace :db do
  desc "Copy the production database to staging"
  task :production_to_staging do
    production_appname = 'womxn-march'
    staging_appname = 'womxn-march-dev'
    newest_backup_name = %x{heroku pg:backups --app #{production_appname} | awk '{print $1 }' | head -n 4 | tail -n 1}.chomp
    url = %x{heroku pg:backups public-url #{newest_backup_name} --app #{production_appname}}.chomp
    puts "Production url: #{url}"
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
    puts %x{curl '#{url}' | pg_restore --verbose --clean --no-acl --no-owner -h localhost -U #{config["username"]} -d #{config["database"]}}
    puts "\n\nData restored from production.\n\n"
  end

  desc "Copy the local database to staging"
  task :local_to_staging do
    staging_appname = 'womxn-march'
    remote_db_name = 'postgresql-cubed-32451'

    config = YAML::load(IO.read(Rails.root.join("config","database.yml")))[Rails.env]
    file_name = "#{config["database"]}-#{Time.now}.dump"
    puts %x{pg_dump -Fc --no-acl --no-owner -h localhost -U #{config["username"]} #{config["database"]} > #{file_name}}

    # upload file to cloud-cube / create CampaignFile
    #TODO: actually upload file

    # if cloud-cube
    # cloudcube_cube_name = "wwzi27gmflta"
    # url = "https://#{ENV['CLOUDCUBE_S3_BUCKET_NAME']}.s3.amazonaws.com/#{cloudcube_cube_name}/public/#{file_name}"

    # if CampaignFile
    # url = file.expiring_url(60)

    %x{heroku pg:backups:restore #{url} #{remote_db_name} --confirm #{staging_appname}}
  end

end
