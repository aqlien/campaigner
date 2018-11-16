require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Campaigner
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/presenters #{config.root}/app/queries)
    config.eager_load_paths << Rails.root.join('lib')

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    config.generators do |g|
      g.orm             :active_record
      g.test_framework  :rspec, spec: true, fixture: false
      g.helpers         false
      g.javascripts     false
      g.stylesheets     false
    end
  end
end
