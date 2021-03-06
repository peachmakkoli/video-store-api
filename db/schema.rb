# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_28_224844) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "registered_at"
    t.string "postal_code"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "videos_checked_out_count", default: 0
    t.string "address"
    t.string "city"
    t.string "state"
    t.index ["videos_checked_out_count"], name: "index_customers_on_videos_checked_out_count"
  end

  create_table "rentals", force: :cascade do |t|
    t.date "due_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "customer_id"
    t.bigint "video_id"
    t.index ["customer_id"], name: "index_rentals_on_customer_id"
    t.index ["video_id"], name: "index_rentals_on_video_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "overview"
    t.date "release_date"
    t.integer "total_inventory"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "available_inventory"
    t.index ["available_inventory"], name: "index_videos_on_available_inventory"
  end

  add_foreign_key "rentals", "customers"
  add_foreign_key "rentals", "videos"
end
