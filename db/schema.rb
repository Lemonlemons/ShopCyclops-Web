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

ActiveRecord::Schema.define(version: 20151019014429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string   "contents"
    t.float    "price"
    t.integer  "quantity"
    t.string   "status"
    t.string   "imageurl"
    t.integer  "progress"
    t.integer  "viewer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "stream_id"
    t.integer  "order_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "flag"
    t.string   "contents"
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "stream_id"
  end

  create_table "orders", force: :cascade do |t|
    t.float    "lat"
    t.float    "lng"
    t.integer  "viewer_id"
    t.integer  "stream_id"
    t.float    "taxrate"
    t.integer  "pricebeforefees"
    t.integer  "pricebeforetax"
    t.integer  "totalprice"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "cardcode"
    t.boolean  "is_delivered",    default: false
    t.string   "signitureurl"
  end

  create_table "streams", force: :cascade do |t|
    t.string   "url"
    t.integer  "host_user_id"
    t.integer  "number_of_watchers"
    t.string   "name"
    t.string   "description"
    t.string   "store"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.float    "lat"
    t.float    "lng"
    t.string   "thumbnail_url"
    t.integer  "progress",           default: 1
    t.integer  "timerlength"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "phonenumber"
    t.string   "displayname"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zipcode"
    t.string   "customertoken"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "publishable_key"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_code"
    t.integer  "reviewpercentage",       default: 100
    t.string   "authentication_token"
    t.boolean  "is_admin",               default: false
    t.boolean  "is_cyclops",             default: false
    t.float    "lat"
    t.float    "lng"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
