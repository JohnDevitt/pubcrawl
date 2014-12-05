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

ActiveRecord::Schema.define(version: 20141205163036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pubs", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pubs_routes", id: false, force: true do |t|
    t.integer "pub_id"
    t.integer "route_id"
  end

  add_index "pubs_routes", ["pub_id", "route_id"], name: "index_pubs_routes_on_pub_id_and_route_id", using: :btree
  add_index "pubs_routes", ["route_id"], name: "index_pubs_routes_on_route_id", using: :btree

  create_table "routes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", force: true do |t|
    t.string   "title"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
