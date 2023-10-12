# spec/controllers/transactions_controller_spec.rb
require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do

  let(:valid_attributes) {
    { email: "test@example.com", serial_number: "123456" }
  }
  
  let(:invalid_attributes) {
    { email: nil, serial_number: nil }
  }

  describe "GET #index" do
    it "assigns all transactions to @transactions" do
      transaction = Transaction.create! valid_attributes
      get :index
      expect(assigns(:transactions)).to match_array(Transaction.all)
    end
    
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end
  
  describe "GET #show" do
    it "assigns the requested transaction to @transaction" do
      transaction = Transaction.create! valid_attributes
      get :show, params: { id: transaction.to_param }
      expect(assigns(:transaction)).to eq(transaction)
    end
  end
  
  describe "POST #create" do
    context "with valid params" do
      it "creates a new Transaction" do
        expect {
          post :create, params: { transaction: valid_attributes }
        }.to change(Transaction, :count).by(1)
      end
      
      it "redirects to the created transaction" do
        post :create, params: { transaction: valid_attributes }
        expect(response).to redirect_to(Transaction.last)
      end
    end
    
    context "with invalid params" do
      it "does not create a new Transaction" do
        expect {
          post :create, params: { transaction: invalid_attributes }
        }.not_to change(Transaction, :count)
      end
      
      it "re-renders the 'new' template" do
        post :create, params: { transaction: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end
  
  describe "DELETE #destroy" do
    it "destroys the requested transaction" do
      transaction = Transaction.create! valid_attributes
      expect {
        delete :destroy, params: { id: transaction.to_param }
      }.to change(Transaction, :count).by(-1)
    end
    
    it "redirects to the transactions list" do
      transaction = Transaction.create! valid_attributes
      delete :destroy, params: { id: transaction.to_param }
      expect(response).to redirect_to(transactions_url)
    end
  end
  
  # Continue with other actions like 'edit', 'update', 'new', 'delete'...
end
