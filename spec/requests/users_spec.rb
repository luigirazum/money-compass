require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /signup' do
    it 'returns http success' do
      get '/signup'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /login' do
    it 'returns http success' do
      get '/login'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /pass/new' do
    it 'returns http success' do
      get '/pass/new'
      expect(response).to have_http_status(:success)
    end
  end
end
