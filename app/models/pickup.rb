class Pickup < ActiveRecord::Base
  belongs_to :follower, class_name: "Day"
  attr_accessible :donor_name, :donor_address_line1, :donor_city, :donor_state, :donor_zip, :donor_email, :pickup_time, :item_description
  
  def self.to_csv(options = {})
      CSV.generate(options) do |csv|
          csv. << column_names
          all.each do |pickup|
              csv << pickup.attributes.values_at(*column_names)
          end
      end
  end
end