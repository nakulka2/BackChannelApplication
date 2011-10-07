require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
   test "invalid with empty reply" do
     reply1=Reply.new
     assert !reply1.valid?
   end
end
