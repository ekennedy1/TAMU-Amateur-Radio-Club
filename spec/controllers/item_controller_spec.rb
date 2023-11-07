# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  render_views

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

  before do
    allow_any_instance_of(ActionView::Base).to receive(:image_tag).and_return('Image')
  end

  describe 'GET #member_items' do
    it 'assigns all available items to @items and renders the member_items template' do
      item = Item.create!(name: 'Test Item', serial_number: '12345', description: 'Test Description', available: true)
      get :member_items
      expect(assigns(:items)).to match_array([item])
      expect(response).to render_template(:member_items)
    end
  end

  describe 'GET #index' do
    it 'assigns all items to @items and renders the index template' do
      Item.create(name: 'Test Item', serial_number: '12345', description: 'Test Description', available: true)
      get :index
      expect(assigns(:items)).to match_array(Item.all)
      expect(response).to render_template(:index)
    end

    # Testing serach functionality on admin inventory page
    # sunny day case
    context 'with search term' do
      it 'returns items that match the search term' do
        Item.create!(name: 'Test Item 1', serial_number: '12345', description: 'Test Description',
                     available: true)
        Item.create!(name: 'Test Item 2', serial_number: '12345', description: 'Test Description',
                     available: true)
        get :index, params: { search: 'Test Item 1' }
        expect(response.body).to include('Test Item 1')
        expect(response.body).not_to include('Test Item 2')
      end
    end

    # rainy day case
    context 'without search term' do
      it 'returns all items when search term is empty' do
        Item.create!(name: 'Test Item 1', serial_number: '12345', description: 'Test Description',
                     available: true)
        Item.create!(name: 'Test Item 2', serial_number: '12345', description: 'Test Description',
                     available: true)
        get :index, params: { search: '' }
        expect(response.body).to include('Test Item 1')
        expect(response.body).to include('Test Item 2')
      end
    end
  end

  # Testing search functionality on member inventory page
  describe 'Get #member_items' do
    # sunny day case
    context 'with search term' do
      it 'returns available items that match the search term' do
        Item.create!(name: 'Test Item 1', serial_number: '12345', description: 'Test Description',
                     available: true)
        Item.create!(name: 'Unavailable Item', serial_number: '12345', description: 'Test Description',
                     available: false)
        get :member_items, params: { search: 'Test Item 1' }
        expect(response.body).to include('Test Item 1')
        expect(response.body).not_to include('Unavailable Item')
      end
    end

    # rainy day case
    context 'without search term' do
      it 'returns all available items when search term is empty' do
        Item.create!(name: 'Testing Item 1', serial_number: '12345', description: 'Test Description',
                     available: true)
        Item.create!(name: 'Testing Item 2', serial_number: '12345', description: 'Test Description',
                     available: true)
        Item.create!(name: 'Unavailable Item', serial_number: '12345', description: 'Test Description',
                     available: false)
        get :member_items, params: { search: '' }
        expect(response.body).to include('Testing Item 1')
        expect(response.body).to include('Testing Item 2')
        expect(response.body).not_to include('Unavailable Item')
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested item to @item and renders the show template' do
      item = Item.create(name: 'Test Item', serial_number: '12345', description: 'Test Description', available: true)
      get :show, params: { id: item.id }
      expect(assigns(:item)).to eq(item)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new item to @item and renders the new template' do
      get :new
      expect(assigns(:item)).to be_a_new(Item)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it "creates a new item and redirects to the item's page with a notice" do
        expect do
          post :create, params: { item: { name: 'Test Item', serial_number: '12345', description: 'Test Description' } }
        end.to change(Item, :count).by(1)
        expect(response).to redirect_to item_path(assigns(:item))
        expect(flash[:notice]).to eq('Item was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new item and re-renders the new template' do
        expect do
          post :create, params: { item: { name: nil, serial_number: '12345', description: 'Test Description' } }
        end.to_not change(Item, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #delete' do
    it 'assigns the requested item to @item and renders the delete template' do
      item = Item.create(name: 'Test Item', serial_number: '12345', description: 'Test Description', available: true)
      get :delete, params: { id: item.id }
      expect(assigns(:item)).to eq(item)
      expect(response).to render_template(:delete)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the item and redirects to the index page with a notice' do
      item = Item.create(name: 'Test Item', serial_number: '12345', description: 'Test Description', available: true)
      expect do
        delete :destroy, params: { id: item.id }
      end.to change(Item, :count).by(-1)
      expect(response).to redirect_to items_path
      expect(flash[:notice]).to eq('Item was successfully removed.')
    end
  end

  # tests for import / export csv function

  # testing export function
  describe 'GET #export' do
    let!(:item) do
      Item.create(name: 'Testing Item', description: 'Testing Description', serial_number: '123456', available: true)
    end

    it 'export items' do
      get :export

      csv = CSV.parse(response.body, headers: true)
      exported_item = csv.first

      expect(response.status).to eq(200)
      expect(exported_item['name']).to eq(item.name)
      expect(exported_item['description']).to eq(item.description)
      expect(exported_item['serial_number']).to eq(item.serial_number)
      expect(exported_item['available']).to eq(item.available.to_s)
    end
  end

  # testing import function
  context 'as an admin user' do
    before(:each) do
      sign_in admin
    end
    describe 'POST #import' do
      let(:csv_file) { fixture_file_upload('items.csv', 'text/csv') }

      it 'import items' do
        # delete all items in the database
        Item.transaction do
          Item.delete_all

          expect { post :import, params: { file: csv_file } }.to change(Item, :count).by(1)

          expect(response).to redirect_to(admin_items_path)
          expect(flash[:notice]).to eq('Items imported successfully!')
          # expect { post :import, params: {file: csv_file } }.to change(Item, :count).by(1)
          expect(Item.first.name).to eq('Testing Item')
          expect(Item.first.description).to eq('Testing Description')
          expect(Item.first.serial_number).to eq('123456')
          expect(Item.first.available).to eq(true)
          # revert the deletion and addition of testing file
          raise ActiveRecord::Rollback
        end
      end

      context 'when csv file is missing' do
        it 'gives an error' do
          post :import

          expect(response).to redirect_to(admin_items_path)
          expect(flash[:alert]).to eq('Please upload a CSV file.')
        end
      end

      context 'when csv file is missing columns' do
        let(:csv_file) { fixture_file_upload('invalid_items.csv', 'test/csv') }

        it 'fails to import items and gives an error' do
          post :import, params: { file: csv_file }

          expect(response).to redirect_to(admin_items_path)
          expect(flash[:alert]).to start_with('There was an issue with importing items.')
          expect { post :import, params: { file: csv_file } }.not_to change(Item, :count)
        end
      end
    end
  end
  #  write tests for edit
end
