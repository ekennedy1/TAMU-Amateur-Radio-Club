require 'rails_helper'

RSpec.describe Item, type: :model do
  context "Validations" do
    it "is valid with valid attributes" do
      item = Item.new(name: "Laptop", description: "A powerful laptop", serial_number: "12345", available: true)
      expect(item).to be_valid
    end

    it "is not valid without a name" do
      item = Item.new(name: nil, description: "A powerful laptop", serial_number: "12345", available: true)
      expect(item).not_to be_valid
    end
    
    it "is not valid without a description" do
      item = Item.new(name: "Laptop", description: nil, serial_number: "12345", available: true)
      expect(item).not_to be_valid
    end
    
    it "is not valid without a serial_number" do
      item = Item.new(name: "Laptop", description: "A powerful laptop", serial_number: nil, available: true)
      expect(item).not_to be_valid
    end
    
    it "is not valid without available attribute" do
      item = Item.new(name: "Laptop", description: "A powerful laptop", serial_number: "12345", available: nil)
      expect(item).not_to be_valid
    end
  end

  # Optionally, if you have any custom methods in your model, write tests for those as well.
end
