class Category < ActiveRecord::Base
  # gem friendly_id
  include FriendlyId
  friendly_id :description, use: :slugged
  
  # Validations
  has_many :ads, dependent: :delete_all
  validates_presence_of :description
  
  # Scopes
  scope :order_by_description, -> { order(:description) }
end
