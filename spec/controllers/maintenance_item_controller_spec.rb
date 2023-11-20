# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MaintenanceItemsController, type: :controller do
  let(:user) do
    User.create!(
      fname: 'First',
      lname: 'Last',
      email: 'test@gmail.com',
      password: 'password123',
      role: 'member'
    )
  end

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
    sign_in user
  end

  let(:valid_attributes) do
    { item_name: 'Test Item', description: 'Test Description', total_amount: 10, available_amount: 5 }
  end

  let(:invalid_attributes) do
    { item_name: '', description: '', total_amount: nil, available_amount: nil }
  end

  let(:maintenance_item) do
    MaintenanceItem.create! valid_attributes
  end

  describe 'GET #index' do
    it 'assigns all maintenance_items to @maintenance_items' do
      get :index
      expect(assigns(:maintenance_items)).to eq([maintenance_item])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested maintenance_item to @maintenance_item' do
      get :show, params: { id: maintenance_item.to_param }
      expect(assigns(:maintenance_item)).to eq(maintenance_item)
    end
  end

  describe 'GET #new' do
    it 'assigns a new maintenance_item to @maintenance_item' do
      get :new
      expect(assigns(:maintenance_item)).to be_a_new(MaintenanceItem)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested maintenance_item to @maintenance_item' do
      get :edit, params: { id: maintenance_item.to_param }
      expect(assigns(:maintenance_item)).to eq(maintenance_item)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new MaintenanceItem' do
        expect do
          post :create, params: { maintenance_item: valid_attributes }
        end.to change(MaintenanceItem, :count).by(1)
      end

      it 'redirects to the created maintenance_item' do
        post :create, params: { maintenance_item: valid_attributes }
        expect(response).to redirect_to(MaintenanceItem.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new MaintenanceItem' do
        expect do
          post :create, params: { maintenance_item: invalid_attributes }
        end.to_not change(MaintenanceItem, :count)
      end

      it "re-renders the 'new' template" do
        post :create, params: { maintenance_item: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { item_name: 'Updated Item', description: 'Updated Description', total_amount: 20, available_amount: 10 }
      end

      it 'updates the requested maintenance_item' do
        put :update, params: { id: maintenance_item.to_param, maintenance_item: new_attributes }
        maintenance_item.reload
        expect(maintenance_item.item_name).to eq('Updated Item')
      end

      it 'redirects to the maintenance_item' do
        put :update, params: { id: maintenance_item.to_param, maintenance_item: new_attributes }
        expect(response).to redirect_to(maintenance_item)
      end
    end

    context 'with invalid params' do
      it 'does not update the maintenance_item' do
        put :update, params: { id: maintenance_item.to_param, maintenance_item: invalid_attributes }
        expect(assigns(:maintenance_item)).to eq(maintenance_item)
      end

      it "re-renders the 'edit' template" do
        put :update, params: { id: maintenance_item.to_param, maintenance_item: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested maintenance_item' do
      maintenance_item # This line is to create an item before attempting to delete it
      expect do
        delete :destroy, params: { id: maintenance_item.to_param }
      end.to change(MaintenanceItem, :count).by(-1)
    end

    it 'redirects to the maintenance_items list' do
      delete :destroy, params: { id: maintenance_item.to_param }
      expect(response).to redirect_to(maintenance_items_url)
    end
  end
end
