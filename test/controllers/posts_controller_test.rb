# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_attrs = {
      title: 'test_title',
      body: 'test_body',
      category_id: categories(:one)[:id]
    }
  end

  test 'index page' do
    get posts_url
    assert_response :success
  end

  test 'show page' do
    get post_url(posts(:one))
    assert_response :success
  end

  test 'new post page with user' do
    sign_in users(:one)
    get new_post_url
    assert_response :success
  end

  test 'new post page without user' do
    get new_post_url
    assert_redirected_to new_user_session_url
  end

  test 'new post with user' do
    sign_in users(:one)

    post posts_url, params: { post: @post_attrs }
    post = Post.find_by @post_attrs.merge(creator_id: users(:one).id)
    assert { post }
    assert_redirected_to post_url(post)
  end

  test 'new post without category' do
    sign_in users(:one)

    params_without_category = {
      title: @post_attrs[:title],
      body: @post_attrs[:body]
    }

    post posts_url, params: { post: params_without_category }
    post = Post.find_by params_without_category
    assert { post.nil? }
  end

  test 'new post without title' do
    sign_in users(:one)

    params_without_title = {
      body: @post_attrs[:body],
      category_id: categories(:one)[:id]
    }

    post posts_url, params: { post: params_without_title }
    post = Post.find_by params_without_title
    assert { post.nil? }
  end

  test 'new post without body' do
    sign_in users(:one)

    params_without_body = {
      title: @post_attrs[:title],
      category_id: categories(:one)[:id]
    }

    post posts_url, params: { post: params_without_body }
    post = Post.find_by params_without_body
    assert { post.nil? }
  end
end
