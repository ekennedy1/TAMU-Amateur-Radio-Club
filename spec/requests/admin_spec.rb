require 'rails_helper'

RSpec.describe "Admins", type: :request do
  include Devise::Test::IntegrationHelpers # Include Devise helpers
  
  describe "GET /index" do
    context "when user is an admin" do
      let(:admin_user) { User.create!(fname: 'admin', lname: 'admin', email: 'admin@example.com', password: 'password', role: 'Admin') }
      
      it "returns http success" do
        sign_in admin_user # Now you can use sign_in
        get "/admin"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
