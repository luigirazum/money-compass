require 'rails_helper'

# 'attr_mod' will allow you to test 'obj'
# with the 'mod' attribute passed.
def attr_mod(mod, obj)
  obj[mod.keys.first] = mod.values.first
  obj
end

RSpec.describe Payment, type: :model do
  let!(:payment_author) { User.create!(name: 'user name') }
  let!(:payment) { described_class.new(name: 'payment name', amount: 1.59, author: payment_author) }

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
      expect(payment).to_not be_valid
      expect { payment.author = 'author' }.to raise_error(ActiveRecord::AssociationTypeMismatch)
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
          expect(payment).to_not be_valid
          new_author = User.new(name: '')
          new_author.validate
          payment.author = new_author
          payment.save
          expect(payment).to_not be_valid
        end
      end
    end
  end
end
