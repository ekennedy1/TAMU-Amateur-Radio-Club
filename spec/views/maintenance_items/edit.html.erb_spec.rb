# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'maintenance_items/edit', type: :view do
  let(:maintenance_item) do
    MaintenanceItem.create!(
      item_name: 'MyString',
      description: 'MyString',
      total_amount: 1,
      available_amount: 1
    )
  end

  before(:each) do
    assign(:maintenance_item, maintenance_item)
  end

  it 'renders the edit maintenance_item form' do
    render

    assert_select 'form[action=?][method=?]', maintenance_item_path(maintenance_item), 'post' do
      assert_select 'input[name=?]', 'maintenance_item[item_name]'

      assert_select 'input[name=?]', 'maintenance_item[description]'

      assert_select 'input[name=?]', 'maintenance_item[total_amount]'

      assert_select 'input[name=?]', 'maintenance_item[available_amount]'
    end
  end
end
