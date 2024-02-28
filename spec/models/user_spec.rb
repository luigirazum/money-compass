require 'rails_helper'

# 'attr_mod' will allow you to test 'obj'
# with the 'mod' attribute passed.
def attr_mod(mod, obj: user)
  obj[mod.keys.first] = mod.values.first
  obj
end

RSpec.describe User, type: :model do
  let!(:user) do
    described_class.new(name: 'user name')
  end

  before { user.save }

  describe ".new 'User' is valid only:", :valid do
    it '- with valid attributes' do
      expect(user).to be_valid
      expect(attr_mod({ name: nil })).to_not be_valid
      expect(attr_mod({ name: '' })).to_not be_valid
      expect(attr_mod({ name: '    ' })).to_not be_valid
    end
  end
end
