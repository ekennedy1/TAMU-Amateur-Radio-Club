class Transaction < ApplicationRecord
    validates :email, :serial_number, presence: true
    validates :approved, presence: true, allow_blank: true
end