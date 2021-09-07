FactoryBot.define do
  factory :user do
    email { Faker::Internet.email.upcase }
    fullname { Faker::Name.name }
    password { "111111" }
    password_confirmation { "111111" }
    phone { "0987654321" }
    address { Faker::Address.full_address }
    role { 1 }
  end
end
