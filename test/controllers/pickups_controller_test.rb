require 'test_helper'
require 'test_helper'

class PickupsControllerTest < ActionController::TestCase

#Set pickup to the first pickup in the .yml
setup do 
  @pickup = Pickup.first
end

#Test the various conroller functions and templates associated with them
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
