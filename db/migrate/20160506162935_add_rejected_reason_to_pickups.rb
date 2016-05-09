class AddRejectedReasonToPickups < ActiveRecord::Migration
  def change
    add_column :pickups, :rejected_reason, :string
  end
end
