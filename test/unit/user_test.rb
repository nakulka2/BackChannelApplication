require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "invalid user with blank username" do
     user=User.new
     assert !user.valid?
   end

  test "invalid user with repeated username" do
     user1=User.new
     user1.username="xyz"
     user2=User.new
     user2.username="xyz"
     assert !user2.valid?
  end

  test "invalid user with blank password" do
     user1=User.new
     user1.username="xyz"
     assert !user1.valid?
    user1.email="email"
  end

  test "invalid user with too short password" do
  user1=User.new
  user1.username="test"
  user1.password="abc"
  user1.email="email"
  assert !user1.valid?
  end

  test "invalid user with too long password" do
  user1=User.new
  user1.username="test"
  user1.password="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  assert !user1.valid?
  end

  test "invalid user with blank email" do
     user1=User.new
     user1.username="xyz"
     user1.password="password"
     assert !user1.valid?
  end


end

