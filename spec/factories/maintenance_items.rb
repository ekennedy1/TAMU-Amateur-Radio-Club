# frozen_string_literal: true

FactoryBot.define do
  factory :maintenance_item do
    item_name { 'MyString' }
    description { 'MyString' }
    total_amount { 1 }
    available_amount { 1 }
  end
end
