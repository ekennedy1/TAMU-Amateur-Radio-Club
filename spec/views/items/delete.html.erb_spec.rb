require 'rails_helper'

RSpec.describe "items/delete.html.erb", type: :view do
  before do
    assign(:item, Item.create!(name: "Test Item", description: "Test Description", serial_number: "12345", available: true))
    render
  end

  it "displays a confirmation message" do
    expect(rendered).to match(/Are you sure you want to permanently delete this item?/)
  end
end
