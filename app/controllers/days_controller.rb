class DaysController < ApplicationController

  #returns the list of all the days ready to paginate
  def schedule1
    @futureDays = Day.where("date >= ?", Date.today.to_s)
    if(@futureDays.empty?)
      flash[:warning] = "There are no days defined."
      render 'pages/schedule/schedule1.html'
    else
      @days = @futureDays.paginate(page: params[:page], per_page: 8)
      render 'pages/schedule/schedule1.html'
    end
  end
    
  #returns the list of all the pickups for the day ready to paginate
  def show
    #get the day
    @day = Day.find_by_id(params[:id])
    #set up pagination
    @pickups = Pickup.where(:day_id => @day.id.to_s)
    if(@pickups.empty?)
      flash[:warning] = "There are no pickups assigned to this day."
      render 'pages/schedule/schedule1.html'
    else
      @pickups.paginate(page: params[:page], per_page: 8)
      render 'pages/schedule/schedule3.html'
    end
  end
  
  def schedule2
    @day = Day.new
    render 'pages/schedule/schedule2.html'
  end
  
  def create
    #convert date hash returned from date_select to a date,
    #see: http://stackoverflow.com/questions/24190996/how-to-convert-a-date-select-hash-into-a-date-object-during-custom-validation-in
    newDay = Date.new(params[:day]['date(1i)'].to_i, params[:day]['date(2i)'].to_i, params[:day]['date(3i)'].to_i)
    if newDay != nil
      @day = Day.new(:date => newDay, :number_of_pickups => 0)
      if @day.save
        flash[:success] = "The day has been added successfully."
        schedule1
      else
        flash[:warning] = "The day could not be created."
        render 'pages/schedule/schedule2.html'
      end
    else
        flash[:warning] = "The day could not be created."
        render 'pages/schedule/schedule2.html'
    end
  end

  private
    def user_params
    end
end