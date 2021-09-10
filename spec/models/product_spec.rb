require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:category) {FactoryBot.create(:category)}
  let!(:first_product) {FactoryBot.create(:product, category_id: category.id)}
  let!(:second_product) {FactoryBot.create(:product, category_id: category.id)}

  describe "associations" do
    it {should have_many(:order_details)}
    it {should have_many(:orders)}
    it {should have_many(:comments)}
    it {should belong_to(:category)}
  end

  describe "scope" do
    it "load by list id" do
      expect(Product.load_by_ids([Product.first.id, Product.second.id])).to eq([first_product, second_product])
    end

    it "sort desc product by id" do
      expect(Product.lastest_product).to eq([second_product, first_product])
    end

    it "sort desc product by id and get 9" do
      expect(Product.lastest_9_product).to eq([second_product, first_product])
    end
  end

  describe "#handle_update_quantity" do
    it {expect(first_product.handle_update_quantity(1)).to be true}
  end
end
