class Ad < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  
  monetize :price_cents
end
