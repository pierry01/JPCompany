class Ad < ActiveRecord::Base
  belongs_to :user
  belongs_to :category, counter_cache: true
  
  validates :title, :description, :category, :price, presence: true
  validates :picture, :finish_date, presence: true
  validates :price, numericality: { greater_than: 0 }
  
  # gem paperclip
  has_attached_file :picture, styles: { large: '800x300#', medium: '320x150#', thumb: '100x100#' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  
  # gem money-rails
  monetize :price_cents
  
  scope :descending_order, ->(quantity = 9) { limit(quantity).order(created_at: :desc) }
  scope :to_the, ->(user) { where(user: user) }
end
