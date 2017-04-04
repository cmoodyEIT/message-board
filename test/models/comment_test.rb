require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def test_belongs_to_user_as_commenter
    comment = Fabricate(:comment)
    assert_kind_of User, comment.commenter
  end
  def test_belongs_to_post
    comment = Fabricate(:comment)
    assert_kind_of Post, comment.post
  end
end
