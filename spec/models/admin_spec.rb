require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'Validations' do
    it { should have_many(:ads)}
  end
end
