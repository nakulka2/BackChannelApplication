require 'test_helper'
#require 'test/unit'

class PostTest < ActiveSupport::TestCase
  fixtures :posts

 test "invalid with empty question" do
   post1 = Post.new
   assert !post1.valid?
 end

end
