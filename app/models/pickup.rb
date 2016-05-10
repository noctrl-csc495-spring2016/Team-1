class Pickup < ActiveRecord::Base
  belongs_to :follower, class_name: "Day"
  validates_presence_of :donor_phone, :donor_name, :donor_address_line1, :donor_zip, :donor_city
  require 'prawn/table'
  
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
          fullAddress = "#{pickup.donor_address_line1} #{pickup.donor_address_line2}"
          #spouse is not in the database. Need for sprint 2 or 3
          csv << [pickup.donor_first_name, "", pickup.donor_name, fullAddress, pickup.donor_city, "Illinois", pickup.donor_zip, pickup.donor_email, pickup.pickup_time, pickup.item_description]
        end
      end
    end
  end
  
  #build the csv file for mapquest - THIS IS LIMITED TO 26 ADDRESSES
  def Pickup.to_route_csv(pickUpDay, fileName)
    #we don't need their unit number to get driving instructions
    CSV.generate(headers: true) do |csv| #generate csv
      #make the headers for the file
      csv << ['Street', 'City', 'State', 'Zip']
      all.each do |pickup|
        #check the pickup day and add if its for the same day
        if pickup.pickup_time.to_s == pickUpDay.to_s 
          csv << [pickup.donor_address_line1, pickup.donor_city, "IL", pickup.donor_zip]
        end
      end
    end
  end
  
  #build the pdf for drivers
  def Pickup.to_reports_pdf(pickUpDay)
    #set counter variable
    i = 1
    #build pdf
    pdf = Prawn::Document.new
    #header of page
    pdf.text "Pickups Scheduled for ", :align => :center, :size => 18
    pdf.move_down 8
    #make the table, grid has really poor syntax and a waste of time. Table is
    #the best, just speficy gem version before publishing
    dataInTable = [["" , "Name/Contact", "Address", "Donor Items/Notes"]]
    all.each do |pickup|
      #check day, then add to pdf
      if pickup.pickup_time.to_s == pickUpDay.to_s
        dataInTable += [[i, "#{pickup.donor_first_name} #{pickup.donor_name}\n#{pickup.donor_phone}", 
          "#{pickup.donor_address_line1}\n#{pickup.donor_address_line2}\n#{pickup.donor_city}",
          "#{pickup.item_description}\n#{pickup.other_notes}\n#{pickup.donor_email}"]]
        i = i+1
      end
    end
    
    pdf.table(dataInTable, :header => true)
    pdf.render
  end
end
