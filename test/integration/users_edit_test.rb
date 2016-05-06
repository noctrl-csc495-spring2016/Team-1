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
    password = "fusbar"
    confirm = "fusbar"
    patch user_path(@user),
    user: { :user_password_digest => password,
            :password_confirmation => confirm,
            :permission_level => "entry" }
            
    @user.reload
    assert_equal password, @user.user_password_digest
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
