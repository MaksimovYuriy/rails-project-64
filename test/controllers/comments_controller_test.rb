# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comments_attrs = {
      content: 'test body com',
      ancestry: '/'
    }
  end

  test 'create comment with user' do
    sign_in users(:one)

    post post_comments_url(posts(:one)), params: { post_comment: @comments_attrs }
    comment = PostComment.find_by @comments_attrs.merge(user_id: users(:one).id, post_id: posts(:one).id)
    assert { comment }
  end

  test 'create comment without user' do
    post post_comments_url(posts(:one)), params: { post_comment: @comments_attrs }
    comment = PostComment.find_by @comments_attrs
    assert_nil comment
    assert_redirected_to new_user_session_url
  end

  test 'create reply-comment' do
    sign_in users(:one)

    reply_comment_params = {
      parent_id: post_comments(:one).id,
      content: 'nested'
    }
    post post_comments_url(posts(:one)), params: { post_comment: reply_comment_params }
    comment = PostComment.last
    assert { comment.ancestry == "/#{post_comments(:one).id}/" }
    assert_equal comment.post_id, posts(:one).id
    assert_equal comment.user_id, users(:one).id
  end
end
