require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def before
    @user ||= login_user
    @post = Fabricate(:post)
  end

  def after
    logout_user
  end
  def test_should_get_index
    get '/posts'
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get '/posts/new'
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post '/posts', post: { user_id: @post.user_id, body: @post.body, title: @post.title }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get '/posts', id: @post
    assert_response :success
  end

  #NOTE: Template removed should remove method from controller and route
  # test "should get edit" do
  #   get "/posts/#{@post.id}/edit"
  #   assert_response :success
  # end

  test "should update post" do
    patch "/posts/#{@post.id}", post: { user_id: @post.user_id, body: @post.body, title: @post.title }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete "/posts/#{@post.id}"
    end
    assert_redirected_to posts_path
  end
end
