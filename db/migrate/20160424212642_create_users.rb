class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :user_email
      t.string :user_password_digest
      t.string :user_name
      t.integer :perission_level
      t.datetime :created_at
      t.datetime :updated_at
      t.string :status

      t.timestamps null: false
    end
  end
end
