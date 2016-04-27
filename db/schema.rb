# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160424220218) do

  create_table "days", force: :cascade do |t|
    t.string   "date"
    t.integer  "number_of_pickups"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "status"
  end

  create_table "pickups", force: :cascade do |t|
    t.integer  "day_id"
    t.string   "donor_name"
    t.string   "donor_address_line1"
    t.string   "donor_address_line2"
    t.string   "donor_city"
    t.string   "donor_zip"
    t.string   "donor_dwelling_type"
    t.string   "donor_location_instructions"
    t.string   "donor_phone"
    t.string   "donor_email"
    t.integer  "number_of_items"
    t.text     "item_description"
    t.text     "other_notes"
    t.string   "pickup_time"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "status"
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_id"
    t.string   "user_email"
    t.string   "user_password_digest"
    t.string   "user_name"
    t.integer  "permission_level"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "status"
  end

end
