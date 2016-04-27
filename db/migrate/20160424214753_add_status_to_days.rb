class AddStatusToDays < ActiveRecord::Migration
  def change
    add_column :days, :status, :string
  end
end
