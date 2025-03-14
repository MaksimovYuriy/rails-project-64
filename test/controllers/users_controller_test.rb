# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attrs = {
      email: 'test_email@mail.ru',
      password: 'testtest',
      password_confirmation: 'testtest'
    }
  end

  test '#new user session page' do
    get new_user_session_url
    assert_response :success
  end

  test '#create user session' do
    user = users(:one)

    post user_session_url, params: { user: {
      email: user.email,
      password: 'password'
    } }

    assert_redirected_to root_url
    assert_equal user, @controller.current_user if defined?(Devise)
  end

  test '#new user page' do
    get new_user_registration_url
    assert_response :success
  end

  test '#sign up user' do
    post user_registration_url, params: { user: @attrs }
    user = User.find_by email: @attrs[:email]

    assert { user }
    assert_redirected_to root_url
    assert_equal user, @controller.current_user if defined?(Devise)
  end

  test '#sign_out' do
    sign_in users(:one)

    delete destroy_user_session_path
    assert_redirected_to new_user_session_path
    assert_nil @controller.current_user
  end
end
