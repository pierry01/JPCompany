#/config/initializers/paperclip.rb

Paperclip::Attachment.default_options.merge!(
  url:                  ':s3_domain_url', #domain-style, e.g: bucket-development.s3-eu-west-1.amazonaws.com
  path:                 '/:class/:attachment/:id/:style/:filename',
  storage:              :s3,
  s3_credentials:       Rails.configuration.aws
)