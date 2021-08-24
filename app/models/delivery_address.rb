class DeliveryAddress < ApplicationRecord
  has_many :order, dependent: :destroy
  belongs_to :user
end
