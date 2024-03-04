require 'rails_helper'

RSpec.describe 'Splash Screen Page', type: :feature do
  describe '* verifying page content' do
    before { visit root_path }

    it "- can see the app name 'MoneyCompass'" do
      expect(page).to have_css('h1', text: 'MoneyCompass')
    end

    context '- action buttons/links' do
      it '> can see [LOG IN] button' do
        expect(page).to have_css('a', text: 'Log in')
        expect(page).to have_link('Log in')
      end

      it '> can see [SIGN UP] link' do
        expect(page).to have_css('a', text: 'Sign up')
        expect(page).to have_link('Sign up')
      end
    end
  end

  describe '* testing interactions' do
    before { visit root_path }

    context '- when clicking on [LOG IN] button' do
      it "> redirects to 'Login' page" do
        click_link('Log in')
        expect(page).to have_current_path(new_user_session_path)
      end
    end

    context '- when clicking on [SIGN UP] link' do
      it "> redirects to 'Sign Up' page" do
        click_link('Sign up')
        expect(page).to have_current_path(new_user_registration_path)
      end
    end
  end
end
