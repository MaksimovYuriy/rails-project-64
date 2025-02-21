require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  test '#home' do
    get root_url
    assert_response :success
  end

  test '#sign_in' do
    get new_user_session_url
    assert_response :success
  end

  test '#sign_up' do
    get new_user_registration_url
    assert_response :success
  end

  test '#sign_out' do
    delete destroy_user_session_path
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end
end
