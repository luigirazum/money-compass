require 'rails_helper'

RSpec.describe "'Payments' Page", type: :feature do
  let!(:icon_link) { 'https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/app_icon.svg' }
  let!(:other) { User.create!(name: 'other user', email: 'other@me.com', password: 'pwd1234') }
  let!(:another) { user.categories.create!(name: 'another category', icon: icon_link) }
  let!(:user) { User.create!(name: 'user name', email: 'user@me.com', password: 'pwd1234') }
  let!(:category) { user.categories.create!(name: 'category #1', icon: icon_link) }
  let!(:payments) do
    (1..5).to_a.map do |p|
      category.payments.create!(name: "payment ##{p}", amount: rand(p) + 1)
    end
  end

  describe '* verifying page content' do
    before do
      sign_in user
      visit category_payments_path(category)
    end

    it "- can see page title 'PAYMENTS'" do
      expect(page).to have_css('h2', text: 'payments')
    end

    it '- can see [<] (back) button' do
      expect(page).to have_link(href: root_path)
    end

    it '- can see [ADD PAYMENT] button' do
      expect(page).to have_link('Add Payment')
    end

    context "- can see the 'category' card" do
      it '> at the top of the list of Payments' do
        expect(page).to have_css('div.category-card')
      end

      it "> can see the 'category' name" do
        selector = 'div.category-card'
        within(selector) do
          expect(page).to have_css('.category__name', text: category.name)
        end
      end

      it "> can see the 'category' total amount" do
        selector = 'div.category-card'
        within(selector) do
          expect(page).to have_css('.category__amount', text: "$#{category.total_amount}")
        end
      end
    end

    describe "- when the user has created 'payments'" do
      it "> can see the list of 'payments'" do
        selector = 'div.content'
        within(selector) do
          expect(page.all('.payment--item').count).to eq(payments.size)
        end
      end

      context "> every 'payment' listed" do
        it "+ can see it's name" do
          payments.each do |p|
            expect(page).to have_css('.payment__name', text: p.name)
          end
        end

        it "+ can see it's amount" do
          payments.each do |p|
            expect(page).to have_css('.payment__amount', text: "$#{p.amount}")
          end
        end

        it "+ can see it's date" do
          payments.each do |p|
            expect(page).to have_css('.payment__date', text: p.created_at.to_date.to_fs(:rfc822))
          end
        end
      end
    end

    context "- when the user hasn't created any 'payments'" do
      before do
        sign_in other
        visit category_payments_path(another)
      end

      it "> can see 'no payments' message" do
        expect(page).to have_css('p', text: 'no payments for this category yet')
      end
    end
  end

  describe '* testing interactions' do
    before do
      sign_in user
      visit category_payments_path(category)
    end

    context '- clicking the [<] (back) button' do
      it "> redirects to 'categories' page" do
        click_link(class: 'btn--nav')
        expect(page).to have_current_path(root_path)
      end
    end

    context '- clicking the [ADD PAYMENT] button' do
      it "> redirects to 'new payment' page" do
        click_link('Add Payment')
        expect(page).to have_current_path(new_category_payment_path(category))
      end
    end
  end
end
