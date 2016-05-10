class Day < ActiveRecord::Base
  has_many :pickups, class_name: "Pickup"
  
  #gets pickups for day and then returns unique cities
  def getTowns
    pickups = Pickup.where(:day_id => self.id.to_s)
    towns = pickups.select(:donor_city).distinct.to_a
    townsString = ""
    towns.each do |town| 
      townsString += " " + town[:donor_city] + ","
    end
    townsString = townsString.chop.strip!
  end
  
  def collect
      "#{date}"
  end
end
