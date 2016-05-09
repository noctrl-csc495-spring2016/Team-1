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
        format.html
        @fileName = params[:fileName]
        @pickUpDay = params[:pickupday]
        if params[:csv] == true
          format.csv { send_data @pickups.to_route_csv(@pickupday, @fileName) }
        end
        if params[:pdf] == true
          format.pdf { send_data @pickups.to_reports_pdf, filename: "pickups.pdf", type: "application/pdf" }
        end
    end
  end
end