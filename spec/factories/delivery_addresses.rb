FactoryBot.define do
  factory :delivery_address do
    user_id { create(:user).id }
    address { Faker::Address.full_address }
    phone_number { "0987654321" }
    fullname { Faker::Name.name }
  end
end
