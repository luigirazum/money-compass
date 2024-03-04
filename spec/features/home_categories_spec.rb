require 'rails_helper'

RSpec.describe "'Categories' Page - 'Home Page'", type: :feature do
  let!(:icon_link) { 'https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/app_icon.svg' }
  let!(:other) { User.create!(name: 'other user', email: 'other@me.com', password: 'pwd1234') }
  let!(:user) { User.create!(name: 'user name', email: 'user@me.com', password: 'pwd1234') }
  let!(:categories) { [] }
  let!(:payments) { {} }

  before do
    (1..4).to_a.each do |n|
      categories << user.categories.create!(name: "category ##{n}", icon: icon_link)
      payments[n.to_s.to_sym] = []
      (1..5).to_a.each do |p|
        payments[n.to_s.to_sym] << categories.last.payments.create!(name: "payment ##{p}", amount: rand(n * p) + 1)
      end
    end
  end

  describe '* verifying page content' do
    before do
      sign_in user
      visit categories_path
    end

    it "- can see page title 'CATEGORIES'" do
      expect(page).to have_css('h2', text: 'categories')
    end

    it '- can see [MENU] button' do
      expect(page).to have_button('navigation')
    end

    describe "- when the user has created 'categories'" do
      it "> can see the list of 'categories'" do
        expect(page).to have_css('ul.content')
        page.all('.category--item').count eq(categories.size)
      end

      context "> every 'category' listed" do
        it "+ can see it's name" do
          categories.each do |c|
            expect(page).to have_css('.category__name', text: c.name)
          end
        end

        it "+ can see it's total amount" do
          categories.each do |c|
            expect(page).to have_css('.category__amount', text: "$#{c.total_amount}")
          end
        end

        it "+ can see it's icon" do
          categories.each do |c|
            expect(page).to have_css("img[src*='#{c.icon}']")
          end
        end

        it "+ it's a clickable 'link'" do
          categories.each do |c|
            expect(page).to have_css("a[href='/categories/#{c.id}/payments']")
          end
        end
      end
    end

    context "- when the user hasn't created any 'categories'" do
      before do
        sign_in other
        visit categories_path
      end

      it "> can see the list of 'categories'" do
        expect(page).to have_css('p', text: 'no categories for this user yet')
      end
    end

    it '- can see the [ADD CATEGORY] button' do
      expect(page).to have_link('Add Category')
    end
  end

  describe '* testing interactions' do
    before do
      sign_in user
      visit categories_path
    end

    context '- clicking the [MENU] button' do
      it "> will open the 'Mobile Menu'" do
        click_on('navigation')
        find('nav')
        expect(page).to have_css('nav')
      end
    end

    context "- clicking a listed 'category'" do
      it "> it redirects to that 'Category's Payments' page" do
        categories.each do |c|
          find("a[href='#{category_payments_path(c)}']").click
          expect(page).to have_current_path(category_payments_path(c))
          visit categories_path
        end
      end
    end

    context "- clicking the 'ADD CATEGORY' button" do
      it "> it redirects to the 'New Category' page" do
        click_link('Add Category')
        expect(page).to have_current_path(new_category_path)
      end
    end
  end
end
