class Product < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  has_many :suggests, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :category

  scope :load_by_ids, ->(ids){where id: ids}
  scope :lastest_product, ->{order(created_at: :desc)}
  scope :lastest_9_product,
        ->{order(created_at: :desc).limit Settings.limit_home_product}

  def handle_update_quantity quantity_order
    update_attribute :quantity, quantity - quantity_order
  end
end
