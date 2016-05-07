require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:one)
  end
  
  test "homepage" do
    get users_index_path
    assert_template 'users/index'
  end
  
  test "new user form" do
    get users_new_path
    assert_template 'users/new'
  end
  
  test "edit page" do
    get edit_user_path(@user)
    assert_template 'users/edit'
  end
  
  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    password = 'foobar'
    confirm = 'foobar'
    level = 'entry'
    patch user_path(@user),
    user: { user_password_digest: password,
            password_confirmation: confirm,
            permission_level: level }
    
    assert_not flash.empty?
    @user.reload
    assert_equal password, @user.user_password_digest
    assert_equal level, @user.permission_level
    assert_redirected_to users_index_path
  end
  
  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { permission_level: "",
                                    user_password_digest: "foo",
                                    password_confirmation: "bar" }
    assert_not flash.empty?
    assert_template 'users/edit'
  end
end
