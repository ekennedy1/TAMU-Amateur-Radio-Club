# spec/controllers/admin_controller_spec.rb
require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let(:admin_user) { create(:user, :admin) } 
  let(:user) { create(:user) }

  describe "GET #index" do
    context "when user is an admin" do
      before { sign_in admin_user }
      
      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end
    
    context "when user is not an admin" do
      before { sign_in user }
      
      it "redirects to the root path" do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
    
    context "when user is not signed in" do
      it "redirects to the sign in page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #users" do
    context "when user is an admin" do
      before { sign_in admin_user }
      
      it "assigns all users to @users" do
        get :users
        expect(assigns(:users)).to eq(User.all)
      end
    end
    
    # similar tests for non-admin user and user not signed in...
  end
  
  describe "GET #transactions" do
    context "when user is an admin" do
      before { sign_in admin_user }
      
      it "assigns all transactions to @transactions" do
        get :transactions
        expect(assigns(:transactions)).to eq(Transaction.all)
      end
    end
    
    # similar tests for non-admin user and user not signed in...
  end
end
