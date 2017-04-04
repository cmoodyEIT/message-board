require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_validates_name
    user = User.new(email: FFaker::Internet.email, password: '123456')
    assert_raises(ActiveRecord::RecordInvalid) {user.save!}
    user.first_name = FFaker::Name.first_name
    user.last_name  = FFaker::Name.last_name
    assert user.save!
  end

  def test_has_associations
    user = Fabricate(:user)
    assert_equal 0, user.posts.length
    assert_equal 0, user.comments.length
  end
end
