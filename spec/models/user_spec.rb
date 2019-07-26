require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Tests' do
    it { expect(Ad.create).to be_invalid }
  end
  
  describe 'Validations' do
    it { should have_many(:ads)}
    it { should have_many(:comments)}
    
    it { should have_one(:profile_user)}
    it { should accept_nested_attributes_for(:profile_user)}
  end
end
