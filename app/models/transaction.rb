class Transaction < ApplicationRecord
    validates :email, :serial_number, presence: true
end