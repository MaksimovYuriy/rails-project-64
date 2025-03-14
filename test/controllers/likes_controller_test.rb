# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  test 'like without user' do
    post post_likes_path(posts(:one))
    assert_redirected_to new_user_session_url
  end

  test 'like with user' do
    sign_in users(:two)

    post post_likes_url(posts(:one))
    assert_redirected_to post_path(posts(:one))

    post_like = PostLike.find_by user: @controller.current_user, post: posts(:one)
    assert { post_like }
  end

  test 'delete like without user' do
    delete post_like_path(posts(:one), post_likes(:one))
    assert_redirected_to new_user_session_url
  end

  test 'delete like with user' do
    sign_in users(:one)
    like = post_likes(:one)

    delete post_like_path(posts(:one), like)
    post_like = PostLike.find_by user: users(:one), post: posts(:one)
    assert { post_like.nil? }
  end
end
