class PickupsController < ApplicationController
    def index
        #need the month and year for the correct pull
        
      @pickups = Pickup.order(:day_id)
      respond_to do |format|
          format.html
          format.csv { send_data @pickups.to_csv }
      end
  end
end
