# Gibbon settings
Gibbon::Request.api_key = ENV["MAILCHIMP_API_KEY"]
Gibbon::Request.timeout = 30
Gibbon::Request.open_timeout = 30
Gibbon::Request.symbolize_keys = true
Gibbon::Request.debug = false


if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:              'smtp.sendgrid.net',
    port:                 587,
    domain:               'heroku.com',
    user_name:            ENV["SENDGRID_USERNAME"],
    password:             ENV["SENDGRID_PASSWORD"],
    authentication:       'plain',
    enable_starttls_auto: true
  }
end
