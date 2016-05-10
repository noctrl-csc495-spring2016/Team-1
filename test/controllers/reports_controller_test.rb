require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get donor" do
    get :donor
    assert_response :success
  end

  test "should get truck" do
    get :truck
    assert_response :success
  end

end
