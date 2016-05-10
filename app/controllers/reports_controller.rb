class ReportsController < ApplicationController
  def donor
    #need the month and year for the correct pull
    @pickups = Pickup.order(:day_id)
    respond_to do |format|
        format.html
        @fileName = params[:filename]
        @date = params[:date]
        #I have no idea why I can't say params[:date]['month'], heres the work around
        @arr = @date.to_s.split(",")
        @month = @arr[0].split("\"")[3]
        if @month.length == 1
          @month.insert(0,'0')
        end
        @year = @arr[1].split("\"")[3]
        format.csv { send_data @pickups.to_donor_csv(@month, @year, @fileName) }
    end
  end

  def truck
    @pickups = Pickup.order(:day_id)
    respond_to do |format|
        @fileName = params[:fileName]
        @pickUpDay = params[:day].to_s.split("\"")[3]
        p @pickUpDay
        format.csv { render text: @pickups.to_route_csv(@pickupday, @fileName) }
        format.pdf { send_data @pickups.to_reports_pdf, filename: "pickups.pdf", type: "application/pdf" }
        format.html
    end
  end
end