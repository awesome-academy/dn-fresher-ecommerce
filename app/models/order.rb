class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  belongs_to :user
  belongs_to :delivery_address

  validates :delivery_address_id, presence: true
end
