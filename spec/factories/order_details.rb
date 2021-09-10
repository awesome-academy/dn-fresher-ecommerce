FactoryBot.define do
  factory :order_detail do
    order_id { create(:order).id }
    product_id { create(:product).id }
    quantity { 2 }
    price { 100000.0}
  end
end
