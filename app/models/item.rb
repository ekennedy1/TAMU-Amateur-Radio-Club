class Item < ApplicationRecord
    validates :name, :description, :serial_number, :available, presence: true

    # change to has_many_atached if you want to attach multiple images
    has_one_attached :image, :dependent => :destroy
  end
