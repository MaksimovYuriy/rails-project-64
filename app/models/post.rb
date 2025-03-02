class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy

  validates :category_id, presence: true
  validates :title, presence: true
  validates :title, length: { minimum: 5, maximum: 200 }
  validates :body, presence: true
  validates :body, length: { minimum: 5, maximum: 1000 }
end
