class Product < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  has_many :suggests, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :category

  scope :load_by_ids, ->(ids){where id: ids}
end
