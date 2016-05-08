class Pickup < ActiveRecord::Base
  belongs_to :follower, class_name: "Day"
  
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
        if pickup.pickup_time == pickUpDay 
          #... add them to the file - more info on csv stuff at http://www.sitepoint.com/guide-ruby-csv-library-part-2/
          #we've got some parsing and concatination so let's do it before we add it.
          firstName = pickup.donor_name.to_s.split(' ')[0]
          lastName = pickup.donor_name.to_s.split(' ')[1]
          fullAddress = "#{pickup.donor_address_line1}\n#{pickup.donor_address_line2}"
          #spouse is not in the database. Need for sprint 2 or 3
          csv << [firstName, "", lastName, fullAddress, pickup.donor_city, "Illinois", pickup.donor_zip, pickup.donor_email, pickup.pickup_time, pickup.item_description]
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
        #if their pickup day is the same as the one being pulled...
        if pickup.pickup_time == pickUpDay 
           #... add them to the file - need to add state and country.
          csv << [pickup.donor_address_line1, pickup.donor_city, "IL", pickup.donor_zip, pickup.item_description]
        end
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
      #Sorry Bill, this isn't going to fit on the page well.
      dataInTable += [[i, "#{pickup.donor_name}\n#{pickup.donor_phone}", 
        "#{pickup.donor_address_line1}\n#{pickup.donor_address_line2}\n#{pickup.donor_city}",
        "#{pickup.item_description}\n#{pickup.other_notes}\n#{pickup.donor_email}"]]
      i = i+1
    end
    
    pdf.table(dataInTable, :header => true)
    pdf.render
  end
end
