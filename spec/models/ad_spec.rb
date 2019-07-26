require 'rails_helper'

RSpec.describe Ad, type: :model do
  describe 'Tests' do
    it { expect(Ad.create).to be_invalid }
  end
  
  describe 'Validations' do
    it { should belong_to(:user) }
    it { should belong_to(:admin) }
    it { should belong_to(:category)}
    
    it { should have_many(:comments)}
    
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:category)}
    it { should validate_presence_of(:picture)}
    it { should validate_presence_of(:finish_date)}
    
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end
end
