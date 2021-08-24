class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :sub_categories, class_name: Category.name,
                            foreign_key: :parent_id,
                            dependent: :destroy
  belongs_to :parent_category, class_name: Category.name, optional: true
end
