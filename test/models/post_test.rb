require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def test_belongs_to_user_as_author
    post = Fabricate(:post)
    assert_kind_of User, post.author
  end

  def test_has_many_comments
    post = Fabricate(:post)
    assert_equal 0, post.comments.length
    assert_difference('post.comments.count') do
      Fabricate(:comment, post: post)
    end
  end

  def test_validates_author_present
    post = Post.new
    assert_raises(ActiveRecord::RecordInvalid) {post.save!}
    post.author = Fabricate(:user)
    assert post.save!
  end

end
