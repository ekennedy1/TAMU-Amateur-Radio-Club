# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'maintenance_items/index', type: :view do
  before(:each) do
    assign(:maintenance_items, [
             MaintenanceItem.create!(
               item_name: 'Item Name',
               description: 'Description',
               total_amount: 2,
               available_amount: 3
             ),
             MaintenanceItem.create!(
               item_name: 'Item Name',
               description: 'Description',
               total_amount: 2,
               available_amount: 3
             )
           ])
  end

  it 'renders a list of maintenance_items' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Item Name'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Description'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
