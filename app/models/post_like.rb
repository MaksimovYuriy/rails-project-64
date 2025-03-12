# frozen_string_literal: true

class PostLike < ApplicationRecord
  validates_uniqueness_of :user_id, scope: [:post_id]

  belongs_to :user
  belongs_to :post, counter_cache: :likes_count
end
