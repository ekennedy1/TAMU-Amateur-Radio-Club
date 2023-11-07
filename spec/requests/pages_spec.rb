require 'rails_helper'

RSpec.describe "Pages", type: :request do
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
  describe "GET /help" do
    it "returns http success" do
      get "/pages/help"
      expect(response).to have_http_status(:success)
    end
  end

end
