require 'rails_helper'

# 'attr_mod' will allow you to test 'obj'
# with the 'mod' attribute passed.
def attr_mod(mod, obj)
  obj[mod.keys.first] = mod.values.first
  obj
end

RSpec.describe Payment, type: :model do
  let!(:payment) { described_class.new(name: 'payment name', amount: 1.59) }

  before { payment.save }

  describe ".new 'Payment' is valid only:", :valid do
    it '- with valid attributes' do
      expect(payment).to be_valid
      expect(attr_mod({ name: nil }, payment)).to_not be_valid
      expect(attr_mod({ name: '' }, payment)).to_not be_valid
      expect(attr_mod({ name: '    ' }, payment)).to_not be_valid
      expect(attr_mod({ amount: nil }, payment)).to_not be_valid
      expect(attr_mod({ amount: '' }, payment)).to_not be_valid
      expect(attr_mod({ amount: 'amount' }, payment)).to_not be_valid
    end
  end
end
