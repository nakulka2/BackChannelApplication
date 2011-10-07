require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  fixtures :users
  fixtures :posts


  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    session[:current_user_id]= 10
    get :new
    #assert_response :success
    assert_redirected_to :controller=> :login, :action => :index

    session[:current_user_id] = nil
    get :new
    assert_redirected_to(:controller => :login, :action => :index)
  end

  test "should create post" do
     session[:current_user_id] = users(:one).id
    assert_difference('Post.count') do
     post :create, :post => {:question => posts(:two).question }

    end
      assert_equal flash[:notice],"Post was successfully created."


    #assert_redirected_to posts_path
  end

  test "should show post" do
    get :show, :id => posts(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => posts(:one).id
    assert_response :success
  end


  test "should destroy post" do
    session[:current_user_id] = posts(:one).user_id
    assert_difference('Post.count', -1) do
      delete :destroy, :id => posts(:one).id
    end

    assert_redirected_to post_manage_posts_path
  end

  test "logged in message displayed" do
    session[:current_user_id]= users(:one).id
   post :index
    assert_equal flash[:login_user], users(:one).username + "  logged in"
  end

  test "logged in as admin" do
  session[:current_user_id] = users(:admin).id
    post :index
   assert_response :success
   end
end
