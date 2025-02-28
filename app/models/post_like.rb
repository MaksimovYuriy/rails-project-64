class PostLike < ApplicationRecord
  validate :check_like_exist

  belongs_to :user
  belongs_to :post

  def self.find_like(user, post)
    PostLike.find_by(user: user, post: post)
  end

  private

  def check_like_exist
    if self.class.exists?(user: user, post: post)
      errors.add(:base, 'This like does exist')
    end
  end

end
