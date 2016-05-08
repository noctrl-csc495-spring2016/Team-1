require 'test_helper'

#Validation tests for pickups
#For a pickup to be vailid, it must have a donor name, phone, city, address line 1, and zip
class PickupTest < ActiveSupport::TestCase
  
  #Create pickup with bare minimum requirements
  def setup
    @pickup = Pickup.new(donor_name: "Prucha", donor_phone: "(630) 555-5555", donor_city: "Naperville", donor_address_line1: "555 Drury Ln", donor_zip: "60540")
  end
  
  test "should be valid" do 
    assert @pickup.valid?
  end
  
  #Test for missing requirements
  test "donor_phone should be present" do
    @pickup.donor_phone = "  "
    assert_not @pickup.valid?
  end
  
  test "donor_name should be present" do
    @pickup.donor_name = "  "
    assert_not @pickup.valid?
  end
  
  test "donor_address should be present" do
    @pickup.donor_address_line1 = "  "
    assert_not @pickup.valid?
  end
  
  test "donor_city should be present" do
    @pickup.donor_city = "  "
    assert_not @pickup.valid?
  end
  
  test "donor_zip should be present" do
    @pickup.donor_zip = "  "
    assert_not @pickup.valid?
  end
end
