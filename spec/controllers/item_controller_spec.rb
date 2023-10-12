require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  render_views

  describe "GET #index" do
    it "assigns all items to @items and renders the index template" do
      item = Item.create(name: "Test Item", serial_number: "12345", description: "Test Description", available: true)
      get :index
      expect(assigns(:items)).to match_array(Item.all)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested item to @item and renders the show template" do
      item = Item.create(name: "Test Item", serial_number: "12345", description: "Test Description", available: true)
      get :show, params: { id: item.id }
      expect(assigns(:item)).to eq(item)
      expect(response).to render_template(:show)
    end
  end
  
  describe "GET #new" do
    it "assigns a new item to @item and renders the new template" do
      get :new
      expect(assigns(:item)).to be_a_new(Item)
      expect(response).to render_template(:new)
    end
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new item and redirects to the item's page with a notice" do
        expect {
          post :create, params: { item: { name: "Test Item", serial_number: "12345", description: "Test Description" } }
        }.to change(Item, :count).by(1)
        expect(response).to redirect_to item_path(assigns(:item))
        expect(flash[:notice]).to eq("Item was successfully created.")
      end
    end

    context "with invalid attributes" do
      it "does not save the new item and re-renders the new template" do
        expect {
          post :create, params: { item: { name: nil, serial_number: "12345", description: "Test Description" } }
        }.to_not change(Item, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #delete" do
    it "assigns the requested item to @item and renders the delete template" do
      item = Item.create(name: "Test Item", serial_number: "12345", description: "Test Description", available: true)
      get :delete, params: { id: item.id }
      expect(assigns(:item)).to eq(item)
      expect(response).to render_template(:delete)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the item and redirects to the index page with a notice" do
      item = Item.create(name: "Test Item", serial_number: "12345", description: "Test Description", available: true)
      expect {
        delete :destroy, params: { id: item.id }
      }.to change(Item, :count).by(-1)
      expect(response).to redirect_to items_path
      expect(flash[:notice]).to eq("Item was successfully removed.")
    end
  end
  
  #  write tests for edit, member_items actions
end
