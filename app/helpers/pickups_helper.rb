module PickupsHelper

#Method to populate the schedule options for the edit pickup form.
#The options_for_select in f.select is used in dropdown menus to populate the options.
#It takes an array of arrays to populate the options. Therefore this method returns an array of arrays
def populate_day_options
    #Ruby on rails can compare date strings to check if a date
    #came before or after another. In this case we are finding all dates today and in the future.
    #We also order the dates in the scheduler using .order('date ASC') with
    #'ASC'meaning ascending order
    @possibleDays = Day.where("date >= '" + Date.today.to_s + "'").order('date ASC')
    
    #Need an array of arrays to populate options_for_select
    optionsArray = Array.new
    
    #Get each possible day and number of pickups associated with that day
    @possibleDays.each do |d|
        dayOption = ""+ get_day_of_week(d.date)+ " ("     + d.number_of_pickups.to_s + check_plurality(d.number_of_pickups) + ")"
        optionsArray.push [dayOption, d.id]  #For each option we must push an array. The first element is the string we want to display, the second is what gets updated in the database when the form is submitted
    end
    return optionsArray
end

#Method to parse the day of the week and date into the desired format.
#The code for strftime and the corresponding % symbols can be viewed here: 
#http://apidock.com/ruby/DateTime/strftime
#Date.parse parses the date_string to date type and strftime then formats the date as desired.
def get_day_of_week(date_string)
    return Date.parse(date_string).strftime("%a, %b %d")
end

#Plurality check to see if pickup or pickups should be written next to a date
#in the scheduler
def check_plurality(numberOfPickups)
    if (numberOfPickups == 1)
        return " pickup"
    else
        return " pickups"
    end
end

end