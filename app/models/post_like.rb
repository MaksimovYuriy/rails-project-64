# frozen_string_literal: true

class PostLike < ApplicationRecord
  validates :user_id, uniqueness: { scope: [:post_id] }

  belongs_to :user
  belongs_to :post, counter_cache: :likes_count
end
