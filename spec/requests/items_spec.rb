require 'rails_helper'

RSpec.describe "Items", type: :request do
  let(:item) { Item.create!(name: 'test', description: 'test', serial_number: '123456', available: true) }

  describe "GET /new" do
    it "returns http success" do
      get "/items/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/items"
      expect(response).to have_http_status(:success)
    end
  end

   describe "GET /show" do
    it "returns http success" do
      get "/items/#{item.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/items/#{item.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /destroy" do
    it "deletes the item" do
      delete "/items/#{item.id}"
      expect(response).to redirect_to(items_path)
    end
  end

end
