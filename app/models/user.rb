class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order_details, through: :orders
  has_many :delivery_addresses, dependent: :destroy

  has_secure_password
end
