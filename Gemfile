source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.7'

# Use postgres as the database for Active Record
gem 'pg'

# Use Puma as the app server
gem 'puma'

# use Devise for user authentication
gem 'devise'
# use Pundit for authorization
gem 'pundit'
# Use UUIDTools, needed for Surveyor redo
gem 'uuidtools'

# Use Bootstrap for page layout and content enhancement
gem 'bootstrap', '~> 4.1.1'
# Bootstrap requires Popper JS and Sprockets
gem 'popper_js', '~> 1.12.9'
gem 'sprockets-rails', '>= 2.3.2'

# Use Bootstrap Form for form styling --- Github release necessary for Rails 5/Bootstrap 4 support as of 2018/05/15
gem "bootstrap_form",
    git: "https://github.com/bootstrap-ruby/bootstrap_form.git",
    branch: "master"

# Add Font Awesome icons
gem "font-awesome-rails"
# use HAML for view templates
gem 'haml-rails'
# Use Mustache for templating
gem 'mustache'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  # use rails12factor for Heroku deployment
  gem 'rails_12factor'
  # use SendGrid as the mail service
  gem 'sendgrid-ruby'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # Use the pry console in development and testing, allows 'binding.pry' to interrupt code
  gem 'pry-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Letter Opener allows previewing mail in the browser instead of sending it
  gem 'letter_opener'
end

group :test do
  # Use RSpec as a testing DSL
  gem 'rspec-rails'
  # FactoryGirl replaces fixtures and provides dynamically loaded content for optimal testing
  gem 'factory_girl_rails', require: false
  gem 'database_cleaner' # cleans database in between tests
  gem 'shoulda-matchers' # allows 'should' in testing DSL
  gem 'rabl' # needed for survey specs
  gem 'rails-controller-testing' # needed for survey controller specs
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
