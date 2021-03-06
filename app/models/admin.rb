class Admin < ActiveRecord::Base
  # Associations
  has_many :ads, dependent: :delete_all
  
  # Enums
  enum role: {full_access: 0, restricted_access: 1}
  
  # Scopes
  scope :with_full_access, -> { where(role: 0) }
  scope :with_restricted_access, -> { where(role: 1) }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
