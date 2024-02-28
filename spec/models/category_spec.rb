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
  let!(:duplicated_category) { described_class.new(name: 'category name', icon: icon_link) }

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

  describe '* attributes', :attributes do
    describe '.name validations' do
      it '- must be provided' do
        expect(attr_mod({ name: nil }, category)).to_not be_valid
        expect(attr_mod({ name: '' }, category)).to_not be_valid
        expect(attr_mod({ name: '  ' }, category)).to_not be_valid
      end

      it '- should not exists (no duplicates)' do
        expect(category).to be_valid
        expect(duplicated_category).to_not be_valid
        expect(attr_mod({ name: 'new name' }, duplicated_category)).to be_valid
      end

      it '- must contain at least 5 characters' do
        expect(attr_mod({ name: 'a' * 4 }, category)).to_not be_valid
        expect(attr_mod({ name: 'a' * 5 }, category)).to be_valid
      end

      it '- must be 35 characters max' do
        expect(attr_mod({ name: 'a' * 36 }, category)).to_not be_valid
        expect(attr_mod({ name: 'a' * 35 }, category)).to be_valid
      end
    end

    describe '.icon validations' do
      it '- must be provided' do
        expect(attr_mod({ icon: nil }, category)).to_not be_valid
        expect(attr_mod({ icon: '' }, category)).to_not be_valid
        expect(attr_mod({ icon: '  ' }, category)).to_not be_valid
      end

      it '- must have a [link] format (http://www.iconadress.com/icon)' do
        expect(attr_mod({ icon: 'icon' }, category)).to_not be_valid
        expect(attr_mod({ icon: 'icon.svg' }, category)).to_not be_valid
        expect(attr_mod({ icon: 'www.icon.com/icon.svg' }, category)).to_not be_valid
      end
    end
  end
end
