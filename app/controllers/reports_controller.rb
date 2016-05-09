class ReportsController < ApplicationController
  def donor
    #need the month and year for the correct pull
    @pickups = Pickup.order(:day_id)
    respond_to do |format|
        format.html
        @fileName = params[:filename]
        @month = params[:month]
        @year = params[:year]
        format.csv { send_data @pickups.to_donor_csv(@month, @year, @fileName) }
    end
  end

  def truck
     @pickups = Pickup.order(:day_id)
    
    respond_to do |format|
        
        @fileName = params[:fileName]
        @pickUpDay = params[:pickupday]
        format.csv { render text: @pickups.to_route_csv(@pickupday, @fileName) }
        format.pdf { send_data @pickups.to_reports_pdf, filename: "pickups.pdf", type: "application/pdf" }
        format.html
    end
  end
end