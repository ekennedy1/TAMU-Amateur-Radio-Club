# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'maintenance_items/new', type: :view do
  before(:each) do
    assign(:maintenance_item, MaintenanceItem.new(
                                item_name: 'MyString',
                                description: 'MyString',
                                total_amount: 1,
                                available_amount: 1
                              ))
  end

  it 'renders new maintenance_item form' do
    render

    assert_select 'form[action=?][method=?]', maintenance_items_path, 'post' do
      assert_select 'input[name=?]', 'maintenance_item[item_name]'

      assert_select 'input[name=?]', 'maintenance_item[description]'

      assert_select 'input[name=?]', 'maintenance_item[total_amount]'

      assert_select 'input[name=?]', 'maintenance_item[available_amount]'
    end
  end
end
