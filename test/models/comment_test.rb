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

  def test_validates_commenter_present
    comment = Comment.new(post: Fabricate(:post))
    assert_raises(ActiveRecord::RecordInvalid) {comment.save!}
    comment.commenter = Fabricate(:user)
    assert comment.save!
  end

  def test_validates_post_present
    comment = Comment.new(commenter: Fabricate(:user))
    assert_raises(ActiveRecord::RecordInvalid) {comment.save!}
    comment.post = Fabricate(:post)
    assert comment.save!
  end
end
