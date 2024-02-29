require 'rails_helper'

# 'attr_mod' will allow you to test 'obj'
# with the 'mod' attribute passed.
def attr_mod(mod, obj)
  obj[mod.keys.first] = mod.values.first
  obj
end

RSpec.describe User, type: :model do
  let!(:icon_link) { 'https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/app_icon_circled.svg' }
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

      it "- can't be repeated (no duplicates)" do
        expect(user).to be_valid
        expect(duplicated_user).not_to be_valid
        expect(attr_mod({ name: 'new name' }, duplicated_user)).to be_valid
      end
    end
  end

  describe '* associations', :associations do
    describe '.categories' do
      context "+ for a 'User.new'" do
        it "- initially contains no 'Categories'" do
          expect(user.categories).to be_empty
          expect(user.categories).to eq([])
          expect(user.categories.size).to eq(0)
        end
      end

      context "+ for a persisted 'User'" do
        it "=> responds for has many 'categories'" do
          association = described_class.reflect_on_association(:categories)
          expect(association.macro).to eq(:has_many)
          expect(user.categories).to be_empty
        end

        it "=> must have only valid 'Category's" do
          category = user.categories.new(name: 'user category', icon: icon_link)
          expect(category).to be_valid
          expect(user).to be_valid
          expect(user.categories.size).to eq(1)
          expect(user.categories.include?(category)).to be_truthy
          expect(attr_mod({ name: '' }, category)).to_not be_valid
          expect(user).to_not be_valid
          expect { user.categories = '' }.to raise_error(NoMethodError)
          expect { user.categories = [5] }.to raise_error(ActiveRecord::AssociationTypeMismatch)
          expect { user.categories = %w[a b c] }.to raise_error(ActiveRecord::AssociationTypeMismatch)
        end
      end
    end

    describe '.payments' do
      context '+ User.new' do
        it "- initially contains no 'Payments'" do
          expect(user.payments).to be_empty
          expect(user.payments).to eq([])
          expect(user.payments.size).to eq(0)
        end
      end

      context "+ for a persisted 'User'" do
        it "=> responds for has many 'payments'" do
          association = described_class.reflect_on_association(:payments)
          expect(association.macro).to eq(:has_many)
          expect(user.payments).to be_empty
        end

        it "=> must have only valid 'Payment's" do
          user_category = user.categories.new(name: 'user category', icon: icon_link)
          payment = user.payments.new(name: 'user payment', amount: 1, category: user_category)
          expect(payment).to be_valid
          expect(user).to be_valid
          expect(user.payments.size).to eq(1)
          expect(user.payments.include?(payment)).to be_truthy
          expect(attr_mod({ name: '' }, payment)).to_not be_valid
          expect(user).to_not be_valid
          expect { user.payments = '' }.to raise_error(NoMethodError)
          expect { user.payments = [5] }.to raise_error(ActiveRecord::AssociationTypeMismatch)
          expect { user.payments = %w[a b c] }.to raise_error(ActiveRecord::AssociationTypeMismatch)
          diff_user = User.create(name: 'another user')
          diff_cat = diff_user.categories.new(name: 'another category', icon: icon_link)
          payment = user.payments.new(name: 'user payment', amount: 1, category: diff_cat)
          expect(payment).to_not be_valid
          expect(user).to_not be_valid
        end
      end
    end
  end
end
