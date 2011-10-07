
require 'test_helper'

class VotesControllerTest < ActionController::TestCase

  fixtures :posts

  setup do
    @vote = votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:votes)
  end


  test "should get new" do
    get :new
    assert_redirected_to(:controller=>:posts, :action=>:index)
  end

  test "should create vote" do
    assert_difference('Vote.count') do
      post :create, vote: @vote.attributes
    end

    assert_redirected_to vote_path(assigns(:vote))
  end


  test "should update vote" do
    put :update, id: @vote.to_param, vote: @vote.attributes
    assert_redirected_to vote_path(assigns(:vote))
  end

  test "post owner should not vote" do
   session[:user_id] = posts(:one).user_id
    get :new, :id=> posts(:one).id

    assert_redirected_to(:controller=>:posts, :action=>:index)

  end

  test "should destroy vote" do
    assert_difference('Vote.count', -1) do
      delete :destroy, id: @vote.to_param
    end
    assert_redirected_to votes_path
  end
end
