class User < ActiveRecord::Base
  # gem ratyrate
  ratyrate_rater
  
  #Associations
  has_many :ads
  has_one :profile_user
  accepts_nested_attributes_for :profile_user
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
