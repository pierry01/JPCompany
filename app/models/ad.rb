class Ad < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  
  # gem paperclip
  has_attached_file :picture, styles: { medium: '320x150#', thumb: '100x100#' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  
  # gem money-rails
  monetize :price_cents
end
