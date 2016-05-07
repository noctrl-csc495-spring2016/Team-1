require 'test_helper'

class PickupsControllerTest < ActionController::TestCase

test "should get pickups" do
  get :index
  assert_response :success
end

test "should get new pickup" do
  get :new
  assert_response :success
end
end
