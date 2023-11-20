# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Consumable, type: :model do
  # Sunny day test example
  it 'is valid with valid attributes' do
    consumable = Consumable.new(name: 'Water Bottle', description: 'A plastic bottle', quantity_remaining: 100)
    expect(consumable).to be_valid
  end

  # Rainy day test example
  it 'is not valid without a name' do
    consumable = Consumable.new(description: 'A plastic bottle', quantity_remaining: 100)
    expect(consumable).not_to be_valid
  end
end
