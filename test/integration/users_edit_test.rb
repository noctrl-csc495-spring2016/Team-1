require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.first
  end
  
  test "homepage" do
    get users_index_path
    assert_template 'users/index'
  end
  
  test "create user" do
    get users_new_path
    assert_template 'users/new'
  end
  
  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user),
    user: { user_password_digest: "fusbar",
            password_confirmation: "fusbar",
            permission_level: "entry" }
    assert_template 'users/index'
  end
  
  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { permission_level: "",
                                    user_password_digest: "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end
end
