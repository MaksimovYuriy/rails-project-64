require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest

  setup do

    @post_attrs = {
      title: 'test_title',
      body: 'test_body',
      category_id: categories(:one)[:id]
    }

    @user_attrs = {
      email: 'test_email@mail.ru',
      password: 'testtest',
      password_confirmation: 'testtest'
    }

    @user = User.create(@user_attrs)
  end

  test 'new post without user' do
    get new_post_url
    assert_response :redirect
    assert_redirected_to new_user_session_url
  end

  test 'new post with user' do 
    post user_session_url, params: { user: {
      email: @user.email,
      password: @user.password
    } }

    post posts_url, params: { post: @post_attrs }
    post = Post.find_by @post_attrs
    assert { post }
    assert_redirected_to post_url(post)
  end

end
