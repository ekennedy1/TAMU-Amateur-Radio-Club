# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'maintenance_items/show', type: :view do
  before(:each) do
    assign(:maintenance_item, MaintenanceItem.create!(
                                item_name: 'Item Name',
                                description: 'Description',
                                total_amount: 2,
                                available_amount: 3
                              ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Item Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
