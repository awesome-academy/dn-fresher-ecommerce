class Comment < ApplicationRecord
  has_many :sub_comments, class_name: Comment.name,
                          foreign_key: :parent_id,
                          dependent: :destroy
  belongs_to :comment_parent, class_name: Comment.name, optional: true
  belongs_to :user
  belongs_to :product
end
