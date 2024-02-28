require 'rails_helper'

# 'attr_mod' will allow you to test 'obj'
# with the 'mod' attribute passed.
def attr_mod(mod, obj)
  obj[mod.keys.first] = mod.values.first
  obj
end

RSpec.describe User, type: :model do
  let!(:user) { described_class.new(name: 'user name') }
  let!(:duplicated_user) { described_class.new(name: 'user name') }

  before { user.save }

  describe ".new 'User' is valid only:", :valid do
    it '- with valid attributes' do
      expect(user).to be_valid
      expect(attr_mod({ name: nil }, user)).to_not be_valid
      expect(attr_mod({ name: '' }, user)).to_not be_valid
      expect(attr_mod({ name: '    ' }, user)).to_not be_valid
    end
  end

  describe '* attributes', :attributes do
    describe '.name validations' do
      it '- must be provided' do
        expect(attr_mod({ name: nil }, user)).to_not be_valid
        expect(attr_mod({ name: '' }, user)).to_not be_valid
        expect(attr_mod({ name: '  ' }, user)).to_not be_valid
      end

      it '- no duplicates allowed' do
        expect(user).to be_valid
        expect(duplicated_user).not_to be_valid
        expect(attr_mod({ name: 'new name' }, duplicated_user)).to be_valid
      end
    end
  end
end
