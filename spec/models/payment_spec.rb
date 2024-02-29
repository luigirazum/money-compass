require 'rails_helper'

# 'attr_mod' will allow you to test 'obj'
# with the 'mod' attribute passed.
def attr_mod(mod, obj)
  obj[mod.keys.first] = mod.values.first
  obj
end

RSpec.describe Payment, type: :model do
  let!(:icon_link) { 'https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/app_icon_circled.svg' }
  let!(:payment_author) { User.create!(name: 'user name') }
  let!(:author_category) { payment_author.categories.create!(name: 'author category', icon: icon_link) }
  let!(:payment) { author_category.payments.new(name: 'payment name', amount: 1.59) }

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
      payment.author = nil
      expect { payment.validate }.to raise_error(NoMethodError)
      expect { payment.author = 'author' }.to raise_error(ActiveRecord::AssociationTypeMismatch)
      expect { payment.category = 'category' }.to raise_error(ActiveRecord::AssociationTypeMismatch)
      diff_author = User.create!(name: 'Diff Author')
      diff_category = diff_author.categories.create!(name: 'Diff Category', icon: icon_link)
      payment.category = diff_category
      expect { payment.validate }.to raise_error(NoMethodError)
    end
  end

  describe '* attributes', :attributes do
    describe '.name validations' do
      it '- must be provided' do
        expect(attr_mod({ name: nil }, payment)).to_not be_valid
        expect(attr_mod({ name: '' }, payment)).to_not be_valid
        expect(attr_mod({ name: '  ' }, payment)).to_not be_valid
      end

      it '- must contain at least 5 characters' do
        expect(attr_mod({ name: 'a' * 4 }, payment)).to_not be_valid
        expect(attr_mod({ name: 'a' * 5 }, payment)).to be_valid
      end

      it '- must be 150 characters max' do
        expect(attr_mod({ name: 'a' * 151 }, payment)).to_not be_valid
        expect(attr_mod({ name: 'a' * 150 }, payment)).to be_valid
      end
    end

    describe '.amount validations' do
      it '- must be provided' do
        expect(attr_mod({ amount: nil }, payment)).to_not be_valid
        expect(attr_mod({ amount: '' }, payment)).to_not be_valid
        expect(attr_mod({ amount: '  ' }, payment)).to_not be_valid
      end

      it '- must be a number' do
        expect(attr_mod({ amount: 'icon' }, payment)).to_not be_valid
        expect(attr_mod({ amount: true }, payment)).to_not be_valid
        expect(attr_mod({ amount: 5 }, payment)).to be_valid
      end

      it '- must be greater than zero' do
        expect(attr_mod({ amount: 0 }, payment)).to_not be_valid
        expect(attr_mod({ amount: -1 }, payment)).to_not be_valid
        expect(attr_mod({ amount: 5 }, payment)).to be_valid
      end
    end
  end

  describe '* associations', :associations do
    describe '.author' do
      it "=> responds for belongs to 'author'" do
        association = described_class.reflect_on_association(:author)
        expect(association.macro).to eq(:belongs_to)
        expect(payment.author).to_not be_nil
      end

      it "=> must be a 'User' instance" do
        expect(payment.author).to be_an_instance_of(User)
        expect { payment.author = 'author' }.to raise_error(ActiveRecord::AssociationTypeMismatch)
      end

      context "=> each 'Payment'" do
        it "+ must have a valid 'Author'" do
          expect(payment.author).to_not be_nil
          payment.author = nil
          expect { payment.validate }.to raise_error(NoMethodError)
          new_author = User.new(name: '')
          new_author.validate
          payment.author = new_author
          payment.save
          expect(payment).to_not be_valid
        end
      end
    end

    describe '.category' do
      it "=> responds for has one 'category'" do
        association = described_class.reflect_on_association(:category)
        expect(association.macro).to eq(:has_one)
        expect(payment.category).to_not be_nil
      end

      it "=> must be a 'Category' instance" do
        expect(payment.category).to be_an_instance_of(Category)
        expect { payment.category = 'category' }.to raise_error(ActiveRecord::AssociationTypeMismatch)
      end

      it "=> 'Category' owner must be the payment's 'Author'" do
        diff_author = User.create(name: 'diff author')
        diff_category = diff_author.categories.create(name: 'diff category', icon: icon_link)
        payment.category = diff_category
        payment.validate
        expect(payment).to_not be_valid
        payment.category = author_category
        payment.validate
        expect(payment).to be_valid
      end

      context "=> each 'Payment'" do
        it "+ must have a valid 'Category'" do
          expect(payment.category).to_not be_nil
          payment.category = nil
          expect(payment).to_not be_valid
          new_category = payment_author.categories.new(name: '', icon: icon_link)
          new_category.validate
          payment.category = new_category
          payment.save
          expect(payment).to_not be_valid
        end
      end
    end
  end
end
