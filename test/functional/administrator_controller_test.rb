require 'test_helper'

class AdministratorControllerTest < ActionController::TestCase
  test "should get create_admin" do
    get :create_admin
    assert_response :success
  end

  test "should get destroy_user" do
    get :destroy_user
    assert_response :success
  end

  test "should get destroy_post" do
    get :destroy_post
    assert_response :success
  end



end
