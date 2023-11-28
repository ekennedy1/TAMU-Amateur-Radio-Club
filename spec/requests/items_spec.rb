# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items', type: :request do
 
  include Devise::Test::IntegrationHelpers
  let(:item) { Item.create!(name: 'test', description: 'test', serial_number: '123456', available: true) }

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
 
  describe 'GET /new' do
    it 'returns http success' do
      get '/items/new'
      expect(response).to have_http_status(:success)
    end
  end
 
  describe 'GET /index' do
    it 'returns http success' do
      get '/items'
 
  describe 'GET /admin/items' do
    it 'returns http success' do
      get admin_items_path
 
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/items/#{item.id}"
      expect(response).to have_http_status(:success)
    end
  end

  # describe "GET /edit" do
  #   it "returns http success" do
  #     get "/items/#{item.id}/edit"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe 'DELETE /destroy' do
    it 'deletes the item' do
      delete "/items/#{item.id}"
      expect(response).to redirect_to(items_path)
    end
  end
end
