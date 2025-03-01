class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
end
