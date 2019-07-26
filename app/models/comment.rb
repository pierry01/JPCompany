class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :ad
  
  validates :body, length: { minimum: 3 }
end
