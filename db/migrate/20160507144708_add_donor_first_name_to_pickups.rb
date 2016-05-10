class AddDonorFirstNameToPickups < ActiveRecord::Migration
  def change
    add_column :pickups, :donor_first_name, :string
  end
end
