require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) do
    described_class.new(name: 'user name')
  end

  before { user.save }

  describe ".new 'User' is valid only:", :valid do
    it '- with valid attributes' do
      expect(user).to be_valid
    end
  end
end
