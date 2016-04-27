class CreatePickups < ActiveRecord::Migration
  def change
    create_table :pickups do |t|
      t.integer :day_id
      t.string :donor_name
      t.string :donor_address_line1
      t.string :donor_address_line2
      t.string :donor_city
      t.string :donor_zip
      t.string :donor_dwelling_type
      t.string :donor_location_instructions
      t.string :donor_phone
      t.string :donor_email
      t.integer :number_of_items
      t.text :item_description
      t.text :other_notes
      t.string :pickup_time

      t.timestamps null: false
    end
  end
end
