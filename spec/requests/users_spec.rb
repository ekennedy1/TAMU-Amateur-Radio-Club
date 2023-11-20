# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
 
  include Devise::Test::IntegrationHelpers

  let(:admin) do
    User.create!(
      fname: 'First',
      lname: 'Last',
      email: 'admin@gmail.com',
      password: 'password123',
      role: 'admin'
    )
  end

  before(:each) do
    sign_in admin
  end
 
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/users/edit'
      expect(response).to have_http_status(:success)
    end
  end
end
