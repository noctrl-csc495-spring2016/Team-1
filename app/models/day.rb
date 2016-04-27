class Day < ActiveRecord::Base
  has_many :pickups, class_name: "Pickup"
  
end
