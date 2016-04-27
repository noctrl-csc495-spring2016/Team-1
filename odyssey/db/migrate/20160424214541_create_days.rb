class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.string :date
      t.integer :number_of_pickups

      t.timestamps null: false
    end
  end
end
