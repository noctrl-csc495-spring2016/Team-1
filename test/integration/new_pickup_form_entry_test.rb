require 'test_helper'

class NewPickupFormEntryTest < ActionDispatch::IntegrationTest

#Test to submit a form with valid pickup information
test "should create new pickup from form" do
  get new_pickup_path
  assert_template 'pickups/new'
  assert_difference 'Pickup.count', 1 do
  post_via_redirect pickups_path, pickup: { donor_name:  'Brown',
                                            donor_phone:  '(630) 555-5555',
                                            donor_address_line1:  '15 Drury Lane',
                                            donor_city: 'Naperville',
                                            donor_zip: '60540' }
  end
  assert_template 'pickups/index'

end  

#Test to submit a form with necessary information missing
test "failed to create new pickup from form" do
  get new_pickup_path
  assert_template 'pickups/new'
  assert_difference 'Pickup.count', 0 do
  post_via_redirect pickups_path, pickup: { donor_name:  ' ',               #missing requirement
                                            donor_phone:  '(630) 555-5555',
                                            donor_address_line1:  '15 Drury Lane',
                                            donor_city: 'Naperville',
                                            donor_zip: '60540' }
  end
  assert flash.empty? == false    #There should be a flash message
  assert_template 'pickups/new'   #Should re-render 'new'
end

end
