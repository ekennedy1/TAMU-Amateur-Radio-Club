FactoryBot.define do
    factory :user do
      fname {"Test"}
      lname {"Admin"}
      email { "admintest@gmail.com" }
      password { "password" }
      password_confirmation { "password" }
      role { "Member" } 
      
      trait :admin do
        role { "Admin" } 
      end
    end
  end
  