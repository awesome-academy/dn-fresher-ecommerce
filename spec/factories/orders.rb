FactoryBot.define do
  factory :order do
    user_id { create(:product).id }
    delivery_address_id { create(:delivery_address).id }
    after(:build) do |order|
      order.order_details << build(:order_detail, order: order)
    end
  end
end
