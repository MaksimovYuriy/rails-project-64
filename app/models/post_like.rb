# frozen_string_literal: true

class PostLike < ApplicationRecord
  validate :check_like_exist

  belongs_to :user
  belongs_to :post

  private

  def check_like_exist
    return unless self.class.exists?(user: user, post: post)

    errors.add(:base, 'This like does exist')
  end
end
