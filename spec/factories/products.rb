FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    content { Faker::Lorem.paragraph }
    quantity { 2 }
    price { 100000.0 }
    category_id { create(:category).id }
  end
end
