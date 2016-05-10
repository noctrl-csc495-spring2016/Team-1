class Pickup < ActiveRecord::Base
  belongs_to :follower, class_name: "Day"
  validates_presence_of :donor_phone, :donor_name, :donor_address_line1, :donor_zip, :donor_city
  require 'prawn/table'
  
  #csv for mapquest -- Not sure if RR made this or if someone else needs the
  #function. RR left in and will evaluate later
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
  
#REPORTS CONTROLS - must be here because it need pickup information  
  #build csv for donor information
  def Pickup.to_donor_csv(month, year, fileName)
    CSV.generate(headers: true) do |csv| #generate csv
    #make a header for the file
      csv << ['FIRST' ,'SPOUSE', 'LAST', 'ADDRESS', 'TOWN', 'STATE', 'ZIP', 
              'E-MAIL', 'DATE DONATED', 'ITEMS DONATED']
      all.each do |pickup|
        #if their pickup day is the same as the one being pulled...
        pickUpDay = pickup.pickup_time
        pickYear = pickUpDay[0] + pickUpDay[1] + pickUpDay[2] + pickUpDay[3]
        pickMon = pickUpDay[5] + pickUpDay[6]
        if month == pickMon && pickYear == year 
          #... add them to the file - more info on csv stuff at http://www.sitepoint.com/guide-ruby-csv-library-part-2/
          #we've got some parsing and concatination so let's do it before we add it.
          lastName = pickup.donor_name.to_s.split(' ')[1]
          fullAddress = "#{pickup.donor_address_line1} #{pickup.donor_address_line2}"
          #spouse is not in the database. Need for sprint 2 or 3
          csv << [pickup.donor_first_name, "", lastName, fullAddress, pickup.donor_city, "Illinois", pickup.donor_zip, pickup.donor_email, pickup.pickup_time, pickup.item_description]
        end
      end
    end
  end
  
  #build the csv file for mapquest - THIS IS LIMITED TO 26 ADDRESSES
  def Pickup.to_route_csv(pickUpDay, fileName)
    #we don't need their unit number to get driving instructions
    CSV.generate(headers: true) do |csv| #generate csv
      #make the headers for the file
      csv << ['Street', 'City', 'State', 'Zip', 'Notes']
      all.each do |pickup|
        p pickup.pickup_time.to_s == pickUpDay
        #if their pickup day is the same as the one being pulled...
        #if pickup.pickup_time.to_s == pickUpDay 
           #... add them to the file - need to add state and country.
          csv << [pickup.donor_address_line1, pickup.donor_city, "IL", pickup.donor_zip, pickup.item_description]
        #end
      end
    end
  end
  
  #build the pdf for drivers
  def Pickup.to_reports_pdf()
    #set counter variable
    i = 1
    #build pdf
    pdf = Prawn::Document.new
    #using texts with a table
    pdf.text "Pickup Schedule for ", :align => :center, :size => 18
    pdf.move_down 8
    #make the table, grid is really poor syntax and a waste of time. Table is
    #the best, just speficy gem version before publishing
    dataInTable = [["" , "Name/Contact", "Address", "Donor Items/Notes"]]
    all.each do |pickup|
      dataInTable += [[i, "#{pickup.donor_name}\n#{pickup.donor_phone}", 
        "#{pickup.donor_address_line1}\n#{pickup.donor_address_line2}\n#{pickup.donor_city}",
        "#{pickup.item_description}\n#{pickup.other_notes}\n#{pickup.donor_email}"]]
      i = i+1
    end
    
    pdf.table(dataInTable, :header => true)
    pdf.render
  end
end
