# Global variables
status = "active"

# Create some ENTRY users
3.times do |n|
  name  = Faker::Name.name
  email = "entry-user-#{n+1}@csc495.org"
  password = "foobar"
  User.create!(user_id:               "entry-user#{n+1}",
              user_name:              name,
              user_email:             email,
              user_password_digest:   password,
              permission_level:       0,
              created_at:             Time.zone.now,
              updated_at:             Time.zone.now,
              status:                 status)
end

# Create some STANDARD users
3.times do |n|
  name  = Faker::Name.name
  email = "standard-user-#{n+1}@csc495.org"
  password = "foobar"
  User.create!(user_id:               "std-user#{n+1}",
              user_name:              name,
              user_email:             email,
              user_password_digest:   password,
              permission_level:       1,
              created_at:             Time.zone.now,
              updated_at:             Time.zone.now,
              status:                 status)
end

# Create some ADMIN users
2.times do |n|
  name  = Faker::Name.name
  email = "admin-user-#{n+1}@csc495.org"
  password = "foobar"
  User.create!(user_id:               "admin-user#{n+1}",
              user_name:              name,
              user_email:             email,
              user_password_digest:   password,
              permission_level:       2,
              created_at:             Time.zone.now,
              updated_at:             Time.zone.now,
              status:                 status)
end

# Create a day
Day.create!(date:                   Date.today.to_s,
            number_of_pickups:      3,
            created_at:             Time.zone.now,
            updated_at:             Time.zone.now,
            status:                 status)
            
Day.create!(date:                   Date.yesterday.to_s,
            number_of_pickups:      0,
            created_at:             Time.zone.now,
            updated_at:             Time.zone.now,
            status:                 status)
              
Day.create!(date:                   Date.tomorrow.to_s,
            number_of_pickups:      0,
            created_at:             Time.zone.now,
            updated_at:             Time.zone.now,
            status:                 status)
              
#create a pickup
Pickup.create!(day_id:              1,
               donor_name:          Faker::Name.name,
               donor_address_line1: "1234 Place St",
               donor_city:          "Naperville",
               donor_zip:           "60565",
               donor_phone:         "6305555555",
               donor_email:         "hi@hi.hi",
               number_of_items:     3,
               pickup_time:         "1:00",
               item_description:    "nothing")
               
#create a pickup
Pickup.create!(day_id:              1,
               donor_name:          Faker::Name.name,
               donor_address_line1: "1234 Place St",
               donor_city:          "Wheaton",
               donor_zip:           "60565",
               donor_phone:         "6305555555",
               donor_email:         "hi@hi.hi",
               number_of_items:     3,
               pickup_time:         "1:00",
               item_description:    "nothing")