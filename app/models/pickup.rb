class Pickup < ActiveRecord::Base
  belongs_to :follower, class_name: "Day"
  validates_presence_of :donor_phone, :donor_name, :donor_address_line1, :donor_zip, :donor_city
  
  
  
  #csv for mapquest
  def self.to_csv(driveDay)
      attributes = %w(donor_address_line1, donor_city, donor_zip, item_description)
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |pickup|
        if pickup.day_id == driveDay
          csv << attributes.map{ |attr| user.send(attr) }
        end
      end
    end
  end
end
