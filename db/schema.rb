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

ActiveRecord::Schema.define(version: 20150219200340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "headline"
    t.string   "source"
    t.integer  "pol_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "balance_for"
    t.float    "balance_against"
    t.string   "social_media_copy"
  end

  create_table "pols", force: true do |t|
    t.string   "bioguide_id"
    t.string   "birthdate"
    t.string   "chamber"
    t.string   "webform"
    t.string   "crp_id"
    t.string   "congresspedia_url"
    t.integer  "district"
    t.string   "facebook_id"
    t.string   "fax"
    t.string   "fec_id"
    t.string   "firstname"
    t.string   "fullname"
    t.string   "gender"
    t.string   "govtrack_id"
    t.string   "lastname"
    t.string   "leadership_role"
    t.string   "middlename"
    t.string   "name_suffix"
    t.string   "nickname"
    t.string   "oc_email"
    t.string   "ocd_id"
    t.string   "official_rss"
    t.string   "congress_office"
    t.string   "party"
    t.string   "phone"
    t.string   "senate_class"
    t.string   "state"
    t.string   "state_name"
    t.string   "term_end"
    t.string   "term_start"
    t.string   "thomas_id"
    t.string   "title"
    t.string   "twitter_id"
    t.string   "votesmart_id"
    t.string   "website"
    t.string   "youtube_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_office"
    t.string   "personal_website"
    t.string   "primary_donation_website"
  end

  create_table "transactions", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.float    "amount"
    t.boolean  "support"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "user_first_name"
    t.string   "user_last_name"
    t.string   "user_street_address"
    t.string   "user_city"
    t.integer  "user_zip"
    t.string   "user_phone"
    t.string   "occupation"
    t.string   "employer_name"
    t.boolean  "unemployed_or_retired"
    t.string   "nonce"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "user_state"
    t.string   "password"
    t.string   "password_digest"
    t.float    "balance"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
