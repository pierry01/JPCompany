require 'rails_helper'

RSpec.describe ProfileUser, type: :model do
  describe 'Validations' do
    it { should belong_to(:user) }
  end
end
