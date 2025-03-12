# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user_attrs = {
      email: 'test_email@mail.ru',
      password: 'testtest',
      password_confirmation: 'testtest'
    }

    @user = User.create(user_attrs)

    @com_attrs = {
      content: 'test body com',
      ancestry: '/'
    }
  end

  test 'create comment with user' do
    post user_session_url, params: { user: {
      email: @user.email,
      password: @user.password
    } }

    post post_comments_url(posts(:one)), params: { post_comment: @com_attrs }
    comment = PostComment.find_by @com_attrs
    assert { comment }
  end

  test 'create comment without user' do
    post post_comments_url(posts(:one)), params: { post_comment: @com_attrs }
    PostComment.find_by @com_attrs
    assert_redirected_to new_user_session_url
  end

  test 'create reply-comment' do
    post user_session_url, params: { user: {
      email: @user.email,
      password: @user.password
    } }

    reply_comment_params = {
      parent_id: post_comments(:one).id,
      content: 'nested'
    }
    post post_comments_url(posts(:one)), params: { post_comment: reply_comment_params }
    comment = PostComment.last
    assert { comment }
    assert { comment.ancestry == "/#{post_comments(:one).id}/" }
  end
end
