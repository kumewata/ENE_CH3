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

ActiveRecord::Schema.define(version: 20180530015457) do

  create_table "energy_productions", force: :cascade do |t|
    t.integer "Label"
    t.integer "House"
    t.integer "Year"
    t.integer "Month"
    t.float "Temperature"
    t.float "Daylight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Daylight"], name: "index_energy_productions_on_Daylight"
    t.index ["Temperature"], name: "index_energy_productions_on_Temperature"
    t.index ["Year", "Month"], name: "index_energy_productions_on_Year_and_Month"
  end

end
