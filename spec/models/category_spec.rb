require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Tests' do
    it { expect(Category.create).to be_invalid }
  end
  
  describe 'Validations' do
    it { should have_many(:ads)}
    it { should validate_presence_of(:description)}
  end
end
