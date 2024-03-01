require 'rails_helper'

# 'attr_mod' will allow you to test 'obj'
# with the 'mod' attribute passed.
def attr_mod(mod, obj)
  obj[mod.keys.first] = mod.values.first
  obj
end

RSpec.describe Category, type: :model do
  let!(:category_owner) do
    User.create!(
      name: 'user name', email: 'email@me.com', password: 'pwd1234', confirmed_at: Time.now
    )
  end
  let!(:icon_link) { 'https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/app_icon_circled.svg' }
  let!(:category) { described_class.new(name: 'category name', icon: icon_link, user: category_owner) }

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
      category.user = User.new(name: 'new user')
      expect(category).to_not be_valid
      expect { category.user = ['user'] }.to raise_error(ActiveRecord::AssociationTypeMismatch)
    end
  end

  describe '* attributes', :attributes do
    describe '.name validations' do
      it '- must be provided' do
        expect(attr_mod({ name: nil }, category)).to_not be_valid
        expect(attr_mod({ name: '' }, category)).to_not be_valid
        expect(attr_mod({ name: '  ' }, category)).to_not be_valid
      end

      it "- can't be repeated (no duplicates), for the same '.user'" do
        expect(category).to be_valid
        duplicated_category = described_class.new(name: 'category name', icon: icon_link, user: category_owner)
        expect(duplicated_category).to_not be_valid
        expect(attr_mod({ name: 'new name' }, duplicated_category)).to be_valid
        diff_owner = User.create(name: 'another user',
                                 email: 'other@me.com', password: 'pwd1234', confirmed_at: Time.now)
        diff_owner_category = described_class.create!(name: 'category name', icon: icon_link, user: diff_owner)
        expect(diff_owner_category).to be_valid
        diff_owner_duplicated_category = described_class.new(name: 'category name', icon: icon_link, user: diff_owner)
        expect(diff_owner_duplicated_category).to_not be_valid
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

  describe '* associations', :associations do
    describe '.user' do
      it "=> responds for belongs to 'user'" do
        association = described_class.reflect_on_association(:user)
        expect(association.macro).to eq(:belongs_to)
        expect(category.user).to_not be_nil
      end

      it "=> must be a 'User' instance" do
        expect(category.user).to be_an_instance_of(User)
        expect { category.user = 'user' }.to raise_error(ActiveRecord::AssociationTypeMismatch)
      end

      context "=> each 'Category'" do
        it "+ must have a valid 'User'" do
          expect(category.user).to_not be_nil
          category.user = nil
          expect(category).to_not be_valid
          new_user = User.new(name: '')
          new_user.validate
          category.user = new_user
          category.save
          expect(category).to_not be_valid
        end
      end
    end

    describe '.payments' do
      it "=> responds for has many 'payments'" do
        association = described_class.reflect_on_association(:payments)
        expect(association.macro).to eq(:has_many)
        expect(category.payments).to_not be_nil
      end

      it "=> must have only 'Payment' instances" do
        category.payments.new(name: 'user payment', amount: 1)
        expect(category.payments.last).to be_an_instance_of(Payment)
        expect { category.payments = 'user' }.to raise_error(NoMethodError)
        expect { category.payments = ['user'] }.to raise_error(ActiveRecord::AssociationTypeMismatch)
      end

      it "=> must have only valid 'Payment's" do
        payment = category.payments.create(name: 'user payment', amount: 1)
        expect(payment).to be_valid
        expect(category).to be_valid
        expect(category.payments.size).to eq(1)
        expect(category.payments.include?(payment)).to be_truthy
        expect(attr_mod({ name: '' }, payment)).to_not be_valid
        expect(category).to_not be_valid
        expect { category.payments = '' }.to raise_error(NoMethodError)
        expect { category.payments = [5] }.to raise_error(ActiveRecord::AssociationTypeMismatch)
        expect { category.payments = %w[a b c] }.to raise_error(ActiveRecord::AssociationTypeMismatch)
        diff_user = User.create(name: 'another user',
                                email: 'other@me.com', password: 'pwd1234', confirmed_at: Time.now)
        diff_cat = diff_user.categories.new(name: 'another category', icon: icon_link)
        payment.category = diff_cat
        expect(payment).to_not be_valid
        expect(category).to_not be_valid
      end
    end
  end
end
