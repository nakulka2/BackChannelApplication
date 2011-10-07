require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  fixtures :users
    test "the truth" do
      assert true
    end
    test "open login page" do
      get :index
      assert_response :success
    end

  test "try to login again" do
    session[:current_user_id] = 10
    get :index
    #assert_response :success
    assert_redirected_to :controller => :posts,  :action => :index
  end

  test "invalid username" do
    post :create, :user => {:username => "invalid", :password => "invalid"}
    assert_equal flash[:no_user],"No such user, please register"
    assert_redirected_to login_index_path
  end

  test "incorrect credentials" do
    post :create, :user =>{:username => users(:one).username, :password => "invalid"}
    assert_equal flash[:wrong_credentials],"Incorrect credentials, please try again"
    assert_redirected_to login_index_path
  end

  test "user logging in" do
    post :create, :user =>{:username => users(:one).username, :password => users(:one).password}
    assert_redirected_to posts_path
  end

end


