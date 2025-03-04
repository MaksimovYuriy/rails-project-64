# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    user_attrs = {
      email: 'test_email@mail.ru',
      password: 'testtest',
      password_confirmation: 'testtest'
    }

    @user = User.create(user_attrs)
  end

  test 'like without user' do
    post post_post_likes_path(posts(:one))
    assert_redirected_to new_user_session_url
  end

  test 'like with user' do
    post user_session_url, params: { user: {
      email: @user.email,
      password: @user.password
    } }

    post post_post_likes_url(posts(:one))
    assert_redirected_to post_path(posts(:one))

    post_like = PostLike.find_by user: @user, post: posts(:one)
    assert { post_like }
  end

  test 'delete like without user' do
    delete post_post_like_path(posts(:one), users(:one))
    assert_redirected_to new_user_session_url
  end

  test 'delete like with user' do
    post user_session_url, params: { user: {
      email: @user.email,
      password: @user.password
    } }

    post post_post_likes_url(posts(:one))
    post_like = PostLike.find_by user: @user, post: posts(:one)
    assert { post_like }

    delete post_post_like_path(posts(:one), @user)
    post_like = PostLike.find_by user: @user, post: posts(:one)
    assert { post_like.nil? }
  end
end
