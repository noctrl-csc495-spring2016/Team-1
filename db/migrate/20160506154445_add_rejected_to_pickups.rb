class AddRejectedToPickups < ActiveRecord::Migration
  def change
    add_column :pickups, :rejected, :boolean, default: false
  end
end
