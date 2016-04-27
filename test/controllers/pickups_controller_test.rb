require 'test_helper'

class PickupsControllerTest < ActionController::TestCase
  setup do
    @pickup = pickups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pickups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pickup" do
    assert_difference('Pickup.count') do
      post :create, pickup: { day_id: @pickup.day_id, donor_address_line1: @pickup.donor_address_line1, donor_address_line2: @pickup.donor_address_line2, donor_city: @pickup.donor_city, donor_dwelling_type: @pickup.donor_dwelling_type, donor_email: @pickup.donor_email, donor_location_instructions: @pickup.donor_location_instructions, donor_name: @pickup.donor_name, donor_phone: @pickup.donor_phone, donor_zip: @pickup.donor_zip, item_description: @pickup.item_description, number_of_items: @pickup.number_of_items, other_notes: @pickup.other_notes, pickup_time: @pickup.pickup_time }
    end

    assert_redirected_to pickup_path(assigns(:pickup))
  end

  test "should show pickup" do
    get :show, id: @pickup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pickup
    assert_response :success
  end

  test "should update pickup" do
    patch :update, id: @pickup, pickup: { day_id: @pickup.day_id, donor_address_line1: @pickup.donor_address_line1, donor_address_line2: @pickup.donor_address_line2, donor_city: @pickup.donor_city, donor_dwelling_type: @pickup.donor_dwelling_type, donor_email: @pickup.donor_email, donor_location_instructions: @pickup.donor_location_instructions, donor_name: @pickup.donor_name, donor_phone: @pickup.donor_phone, donor_zip: @pickup.donor_zip, item_description: @pickup.item_description, number_of_items: @pickup.number_of_items, other_notes: @pickup.other_notes, pickup_time: @pickup.pickup_time }
    assert_redirected_to pickup_path(assigns(:pickup))
  end

  test "should destroy pickup" do
    assert_difference('Pickup.count', -1) do
      delete :destroy, id: @pickup
    end

    assert_redirected_to pickups_path
  end
end
