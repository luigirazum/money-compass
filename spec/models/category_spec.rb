require 'rails_helper'

# 'attr_mod' will allow you to test 'obj'
# with the 'mod' attribute passed.
def attr_mod(mod, obj)
  obj[mod.keys.first] = mod.values.first
  obj
end

RSpec.describe Category, type: :model do
  let!(:icon_link) { 'https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/app_icon_circled.svg' }
  let!(:category) { described_class.new(name: 'category name', icon: icon_link) }

  before { category.save }

  describe ".new 'Category' is valid only:", :valid do
    it '- with valid attributes' do
      expect(category).to be_valid
      expect(attr_mod({ name: nil }, category)).to_not be_valid
      expect(attr_mod({ name: '' }, category)).to_not be_valid
      expect(attr_mod({ name: '    ' }, category)).to_not be_valid
      expect(attr_mod({ icon: nil }, category)).to_not be_valid
      expect(attr_mod({ icon: '' }, category)).to_not be_valid
      expect(attr_mod({ icon: '    ' }, category)).to_not be_valid
    end
  end
end
