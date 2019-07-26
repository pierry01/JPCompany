require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Tests' do
    it { expect(Comment.create).to be_invalid }
  end
  
  describe 'Validations' do
    it { should belong_to(:user) }
    it { should belong_to(:ad)}
    it { should validate_length_of(:body).is_at_least(3) }
  end
end
