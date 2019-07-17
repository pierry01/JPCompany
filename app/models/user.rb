class User < ActiveRecord::Base
  # gem ratyrate
  ratyrate_rater
  
  #Associations
  has_many :ads, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_one :profile_user
  accepts_nested_attributes_for :profile_user
  
  # Validations
  validate :nested_attributes
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def nested_attributes
    if nested_attributes_blank?
      errors.add(:base, 'É necessário preencher o nome e o sobrenome.')
    end
  end
  
  def nested_attributes_blank?
    profile_user.first_name.blank? || profile_user.second_name.blank?
  end
end
