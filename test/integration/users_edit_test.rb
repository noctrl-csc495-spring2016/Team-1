require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.first
  end
  
  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user),
    user: { user_password_digest: "fusbar",
            password_confirmation: "fusbar",
            permission_level: "entry" }
    assert_not flash.empty?
    assert_redirected_to 'users/index'
  end
  
  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { permission_level: "",
                                    user_password_digest: "foo",
                                    password_confirmation: "bar" }
    assert_redirected_to 'users/edit'
  end
end
