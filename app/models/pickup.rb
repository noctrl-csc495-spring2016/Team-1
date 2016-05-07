class Pickup < ActiveRecord::Base
  belongs_to :follower, class_name: "Day"
  validates_presence_of :donor_phone, :donor_name, :donor_address_line1, :donor_zip, :donor_city
  
  
end
