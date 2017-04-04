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
end
