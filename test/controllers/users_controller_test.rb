require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @attrs = {
      email: 'test_email@mail.ru',
      password: 'testtest',
      password_confirmation: 'testtest'
    }
  end

  test '#home' do
    get root_url
    assert_response :success
  end

  test '#sign_in' do
    get new_user_session_url
    assert_response :success

    user = User.create(@attrs)

    post user_session_url, params: { user: {
      email: user.email,
      password: user.password
    } }

    assert_response :redirect
    assert_redirected_to root_url
  end

  test '#sign_up' do
    get new_user_registration_url
    assert_response :success

    post user_registration_url, params: { user: @attrs }
    user = User.find_by email: @attrs[:email]

    assert { user }
    assert_redirected_to root_url
  end

  test '#sign_out' do
    user = User.create(@attrs)

    post user_session_url, params: { user: {
      email: user.email,
      password: user.password
    } }

    delete destroy_user_session_path
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

end
