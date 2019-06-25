class Ad < ActiveRecord::Base
  # Constants
  QTT_PER_PAGE = 6
  
  #gem ratyrate
  ratyrate_rateable 'quality'
  
  # Associations
  belongs_to :user
  belongs_to :category, counter_cache: true
  has_many :comments
  
  validates :title, :description, :category, :price, presence: true
  validates :picture, :finish_date, presence: true
  validates :price, numericality: { greater_than: 0 }
  
  # gem paperclip
  has_attached_file :picture, styles: { large: '800x300#', medium: '320x150#', thumb: '100x100#' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  
  # gem money-rails
  monetize :price_cents
  
  #Scopes
  scope :descending_order, ->(page) { 
    order(created_at: :desc).page(page).per(QTT_PER_PAGE) 
  }
  
  scope :search, ->(term, page) { 
    where("lower(title) LIKE ?", "%#{term.downcase}%").page(page).per(QTT_PER_PAGE)
  }
  
  scope :by_category, ->(id, page) { 
    where(category: id).page(page).per(QTT_PER_PAGE).order(created_at: :desc)
  }
  
  scope :to_the, ->(user) { where(user: user) }
end
