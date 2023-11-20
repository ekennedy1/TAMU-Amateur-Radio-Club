FactoryBot.define do
  factory :consumable do
    name { "MyString" }
    description { "MyText" }
    quantity_remaining { 1 }
  end
end
