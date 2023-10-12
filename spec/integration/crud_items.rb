require 'rails_helper'

RSpec.describe "CRUD_Item_integration_tests", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'enables the user to create an item and displays it' do
    visit root_path
    click_on "Add Item"
    
    fill_in 'Name', with: 'Laptop'
    fill_in 'Description', with: 'A very cool laptop'
    fill_in 'Serial number', with: '9393493'

    click_on 'Create Item'

    expect(page).to have_content('Item was successfully created.')
    expect(page).to have_content('Laptop')
    expect(page).to have_content('A very cool laptop')
    expect(page).to have_content('9393493')

    item = Item.order("id").last
    expect(item.name).to eq('Laptop')
    expect(item.description).to eq('A very cool laptop')
    expect(item.serial_number).to eq('9393493')
  end

  it 'does not allow the user to create an item with invalid inputs' do
    visit root_path
    click_on "Add Item"
  
    fill_in 'Name', with: '' # Leaving it blank to trigger validation error
    click_on 'Create Item'
    
    expect(page).to have_content("Name can't be blank")
    expect(Item.count).to eq(0) # No item should be created
  end

  # it 'allows the user to edit an item' do
  #   item = Item.create!(name: 'Old Laptop', description: 'A very old laptop', serial_number: '1234567', available: true)
    
  #   visit edit_item_path(item)
    
  #   fill_in 'Name', with: 'Updated Laptop'
  #   click_on 'Update Item'
  
  #   expect(page).to have_content('Item was successfully updated.')
  #   expect(page).to have_content('Updated Laptop')
    
  #   updated_item = Item.find(item.id)
  #   expect(updated_item.name).to eq('Updated Laptop')
  # end
  

  it 'allows the user to delete an item' do
    item = Item.create!(name: 'Unwanted Laptop', description: 'A very unwanted laptop', serial_number: '7654321', available: true)
    
    visit item_path(item)
    click_on 'Delete this item'
    
    click_on 'Delete Item'

    expect(page).to have_content('Item was successfully removed.')
    expect(Item.count).to eq(0) # The item should be deleted
  end
  
  it 'allows the user to view an item' do
    item = Item.create!(name: 'Viewable Laptop', description: 'A very viewable laptop', serial_number: '123456789',  available: true)
    
    visit item_path(item)
    
    expect(page).to have_content('Viewable Laptop')
    expect(page).to have_content('A very viewable laptop')
    expect(page).to have_content('123456789')
  end
  
end
