# Settings used by all models with file attachments:
case Rails.env
when "test"
  # don't do anything special, use paperclip defaults for local testing.
else
  Paperclip::Attachment.default_options[:storage] = :s3
  Paperclip::Attachment.default_options[:s3_protocol] = "https"
  Paperclip::Attachment.default_options[:s3_credentials] = {
    bucket: ENV['CAMPAIGNER_S3_BUCKET_NAME'],
    access_key_id: ENV['CAMPAIGNER_AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['CAMPAIGNER_AWS_SECRET_ACCESS_KEY'],
    s3_region: ENV['CAMPAIGNER_AWS_REGION'],
  }
  Paperclip::Attachment.default_options[:s3_permissions] = 'private'
  Paperclip::Attachment.default_options[:bucket] = ENV['CAMPAIGNER_S3_BUCKET_NAME']
end

Paperclip.options[:content_type_mappings] = {
  dump: %w(text/plain inode/x-empty),
  dmp: %w(text/plain inode/x-empty)
}
