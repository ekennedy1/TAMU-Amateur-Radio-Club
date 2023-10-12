class Item < ApplicationRecord
    validates :name, :description, :serial_number, :available, presence: true
  end
  