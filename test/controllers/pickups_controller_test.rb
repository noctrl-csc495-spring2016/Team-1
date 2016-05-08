require 'test_helper'
require 'test_helper'

class PickupsControllerTest < ActionController::TestCase

setup do 
  @pickup = Pickup.first
end

test "should get pickups" do
  get :index
  assert_response :success
  assert_template 'pickups/index'
end

test "should get new pickup" do
  get :new
  assert_response :success
  assert_template 'pickups/new'
  assert_select "a[href=?]", pickups_path
end

test "should get edit" do
  get :edit, :id => @pickup.id
  assert_response :success
  assert_template 'pickups/edit'
  assert_select "a[href=?]", pickups_path
end

end
