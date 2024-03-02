require 'rails_helper'

RSpec.describe 'Screens', type: :request do
  let!(:user) { User.create!(name: 'user name', email: 'user@me.com', password: 'pwd1234', confirmed_at: Time.now) }

  describe '* GET /splash' do
    it '- returns http success' do
      get splash_screen_path
      expect(response).to have_http_status(:success)
    end

    context '- when a user is signed in' do
      it "- redirects to 'home'('categories') page" do
        sign_in user
        get splash_screen_path
        expect(request.url).to eq(splash_screen_url)
        expect(response.location).to eq(categories_url)
      end
    end

    context '- when there is no user signed in' do
      it "- redirects to 'splash screen' page" do
        get splash_screen_path
        expect(request.url).to eq(splash_screen_url)
      end
    end
  end
end
