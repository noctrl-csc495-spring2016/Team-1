require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = User.find(params[:id])
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { created_at: @user.created_at, perission_level: @user.perission_level, status: @user.status, updated_at: @user.updated_at, user_email: @user.user_email, user_id: @user.user_id, user_name: @user.user_name, user_password_digest: @user.user_password_digest }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { created_at: @user.created_at, perission_level: @user.perission_level, status: @user.status, updated_at: @user.updated_at, user_email: @user.user_email, user_id: @user.user_id, user_name: @user.user_name, user_password_digest: @user.user_password_digest }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
