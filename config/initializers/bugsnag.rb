if Rails.env.production?
  Bugsnag.configure do |config|
    config.api_key = ENV['CAMPAIGNER_BUGSNAG_API_KEY']
  end
end
