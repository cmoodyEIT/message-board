class ActionDispatch::IntegrationTest
  def login_user
    @user = User.first || Fabricate(:user)
    post_via_redirect '/users/sign_in', { user: {email: @user.email, password: @user.password} }, {user_return_to: '/'}
    follow_redirect! while redirect?
    assert_response :success
    return @user
  end

  def logout_user
    delete '/users/sign_out'
    follow_redirect! while redirect?
    assert_response :success
  end

end
