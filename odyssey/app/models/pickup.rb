class Pickup < ActiveRecord::Base
  belongs_to :follower, class_name: "Day"
  
end
