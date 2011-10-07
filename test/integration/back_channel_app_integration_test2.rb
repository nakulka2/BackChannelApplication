require "test_helper"
require "capybara/rails"
require "test/unit"

class BackChannelAppIntegrationTest2 < ActionDispatch::IntegrationTest
  fixtures :all
  test "the truth" do
    assert true
  end

  test "create posts from main page" do
    visit(posts_path)
    click_link("Login")
    fill_in "userName", :with => users(:one).username
    fill_in "password", :with => users(:one).password
   click_button "Login"
    click_link "New Post"
    fill_in "Question", :with => "question"
    click_button "Create Post"
    click_link "View posts"
    click_link ("Logout")
  end

  test "register new user" do
    visit(posts_path)
    click_link("Login")
    click_link("register")
    fill_in "Username", :with => "user123"
    fill_in "Password", :with => "xxxxxx"
    fill_in "Email", :with => "user@backchannelapp.com"
    click_button "Create User"
  end

  test "create admin account" do
    visit(posts_path)
    click_link("Login")
    fill_in "userName", :with => users(:admin).username
    fill_in "password", :with => users(:admin).password
    click_button "Login"
    click_link "Create admin account"
    fill_in "Username", :with => "admin111"
    fill_in "Password", :with => "1234455"
    fill_in "Email", :with => "admin111@backchannelapp.com"
    click_button "Create User"
    click_link "Home"
    click_link ("Logout")
  end

  test "view stats" do
    visit(posts_path)
    click_button "Login"
    fill_in "userName", :with => users(:admin).username
    fill_in "password", :with => users(:admin).password
    click_link("Login")
    click_link "Stats"
    click_link "Home"
    click_link "Logout"
  end

  test "view posts" do
    visit(posts_path)
    click_link("Login")
    fill_in "userName", :with => users(:admin).username
    fill_in "password", :with => users(:admin).password
   click_button "Login"
    click_link "Posts"
    click_link ("Logout")
  end
end



