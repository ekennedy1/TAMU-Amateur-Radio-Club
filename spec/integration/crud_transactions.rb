require 'rails_helper'

RSpec.describe "CRUD_Item_integration_tests", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'enables the user to create an item and displays it' do
    visit transactions_path
    click_on 'Add Transaction'

    fill_in 'Email', with: 'test@gmail.com'
    fill_in 'Serial number', with: '123456'
    click_on 'Create Transaction'

    expect(page).to have_content('Transaction was successfully created.')
    expect(page).to have_content('test@gmail.com')
    expect(page).to have_content('123456')

    transaction = Transaction.order("id").last
    expect(transaction.email).to eq('test@gmail.com')
    expect(transaction.serial_number).to eq('123456')
  end

  it 'does not allow the user to create a transaction with invalid inputs' do
    visit transactions_path
    click_on 'Add Transaction'
    
    click_on 'Create Transaction' # Trying to create a transaction with no input
    
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Serial number can't be blank")
    expect(Transaction.count).to eq(0) # Ensure no transactions are created
  end

  it 'allows the user to delete a transaction' do
    transaction = Transaction.create!(email: 'delete_me@gmail.com', serial_number: '111111')
    
    visit transaction_path(transaction)
    click_on 'Delete'

    click_on 'Delete Transaction'
    
    expect(page).to have_content('Transaction was successfully removed.')
    expect(Transaction.count).to eq(0) # Ensure the transaction is deleted
  end

  it 'allows the user to view a transaction detail' do
    transaction = Transaction.create!(email: 'view_me@gmail.com', serial_number: '999999')
    
    visit transaction_path(transaction)
    
    expect(page).to have_content('view_me@gmail.com')
    expect(page).to have_content('999999')
  end
  
  
end
