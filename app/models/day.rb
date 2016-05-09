class Day < ActiveRecord::Base
  has_many :pickups, class_name: "Pickup"
  def collect
      "#{date}"
  end
end
