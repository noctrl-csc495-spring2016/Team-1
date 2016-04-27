class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :perission_level, :permission_level
  end
end
