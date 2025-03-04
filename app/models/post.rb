# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: 'User'

  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy

  validates :title, presence: true
  validates :title, length: { minimum: 5, maximum: 200 }
  validates :body, presence: true
  validates :body, length: { minimum: 5, maximum: 1000 }
end
