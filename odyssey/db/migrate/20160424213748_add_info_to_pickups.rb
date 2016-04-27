class AddInfoToPickups < ActiveRecord::Migration
  def change
    add_column :pickups, :status, :string
  end
end
