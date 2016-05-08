class PickupsController < ApplicationController

#Bullpen page.
#Display all pickups where the day_id is null and the rejected flag is false
def index
    @pickups = Pickup.where({day_id: nil, rejected: false})
end

#Create a new Pickup
def create
  @pickup = Pickup.new(pickup_params)                    #Pass pickup params from form into new pickup
    if @pickup.save                                      #Saves if required fields were filled in.
        flash[:success] = "Pickup has been added."
        redirect_to "/pickups"
    else
        flash.now[:danger] = "Required fields were left blank."
        render 'new'
    end
end

#Show the pickup whose id was accessed
def show
    @pickups = Pickup.find(params[:id])
end

#Update a pickup
#Information is submitted when one of the buttons on the edit form is clicked.
#Because the edit form contains five potential buttons (update donor, schedule, reschedule, reject, and cancel),
#we need five separate cases.
#http://stackoverflow.com/questions/3332449/rails-multi-submit-buttons-in-one-form
def update
    @pickup = Pickup.find(params[:id])
    if params[:update]                                              #Update donor button was clicked
        if @pickup.update_attributes(pickup_params)
            flash[:success] = "Pickup information has been updated."
            redirect_to "/pickups"
        else
            flash.now[:danger] = "Required fields were left blank."
            render 'edit'
        end
    elsif params[:schedule]                                         #Schedule button was clicked
        if @pickup.update_attributes(day_and_pickup_params)
            @newDay = Day.find_by id: @pickup.day_id
            @newDay.number_of_pickups +=1
            @newDay.save
            flash[:success] = "Pickup has been scheduled."
            redirect_to "/pickups"
        else 
            flash.now[:danger] = "Pickup could not be scheduled."
            render 'edit'
        end
    elsif params[:reschedule]                                       #Reschedule button was clicked
        @myDay = Day.find_by id: @pickup.day_id
        @myDay.number_of_pickups -=1
        @myDay.save
        if @pickup.update_attributes(day_and_pickup_params)
            @newDay = Day.find_by id: @pickup.day_id
            @newDay.number_of_pickups +=1
            @newDay.save
            flash[:success] = "Pickup has been rescheduled."
            redirect_to "/pickups"
        else
            @myDay.number_of_pickups +=1
            @myDay.save
            flash.now[:danger] = "Pickup could not be rescheduled."
            render 'edit'
        end    
    elsif params[:reject]                                           #Reject Button was clicked
        if @pickup.day_id != nil                                    #If the pickup was already scheduled, 
            @myDay = Day.find_by id: @pickup.day_id                 #subtract 1 from the number of pickups for that day
            @myDay.number_of_pickups -= 1
            @pickup.day_id = nil                                    #Also set pickup's day_id to null
            @myDay.save
        end
        @pickup.rejected = true                                     #Set rejected to true and update the rejected params
        if @pickup.update_attributes(rejected_params)
            flash[:success] = "Pickup has been rejected."
            redirect_to "/pickups"
        else
            flash.now[:danger] = "Pickup could not be rejected."
            render 'edit'
        end
    elsif params[:cancel]                                           #Cancel button was clicked
        redirect_to "/pickups"
    end
end

#Define a new Pickup
def new
    @pickup = Pickup.new
end

#Edit a pickup
#Set the pickup fields on the edit page to the pickup whose id was accessed
def edit
    @pickup = Pickup.find(params[:id])
end



#Permit the donor/pickup information to be updated if the update donor button is clicked
def pickup_params
    params.require(:pickup).permit(:donor_name, :donor_first_name, :donor_email, :donor_address_line1, :donor_address_line2,
    :donor_phone, :donor_city, :donor_zip, :donor_dwelling_type, :other_notes, :item_description, :number_of_items)
end

#Permit the donor/pickup information and schedule information to be updated if schedule
#button is clicked
def day_and_pickup_params
    params.require(:pickup).permit(:donor_name, :donor_first_name, :donor_email, :donor_address_line1, :donor_address_line2,
    :donor_phone, :donor_city, :donor_zip, :donor_dwelling_type, :other_notes, :item_description, :number_of_items, :day_id)
end

#Permit the rejected fields to be updated in database if reject button is clicked
def rejected_params
    params.require(:pickup).permit(:rejected, :rejected_reason)
end

end
