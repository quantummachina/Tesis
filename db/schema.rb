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

ActiveRecord::Schema.define(version: 20141204224006) do

  create_table "carts", force: true do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ftweets", force: true do |t|
    t.integer  "tid",        default: 0
    t.string   "text",       default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fwords", force: true do |t|
    t.string   "s",          default: ""
    t.integer  "n",          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "target2s", force: true do |t|
    t.integer  "target_id"
    t.integer  "uid",         default: 0
    t.string   "name",        default: ""
    t.string   "screen_name", default: ""
    t.integer  "nfollowers",  default: 0
    t.integer  "nfriends",    default: 0
    t.float    "f2f",         default: 0.0
    t.integer  "nfavorites",  default: 0
    t.integer  "ntweets",     default: 0
    t.boolean  "spamed",      default: false
    t.boolean  "retained",    default: false
    t.integer  "since",       default: 0
    t.integer  "nlisted",     default: 0
    t.integer  "utcoffset",   default: 0
    t.integer  "beak",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "tfr",         default: 0.0
    t.float    "ffr",         default: 0.0
    t.integer  "group",       default: 0
  end

  create_table "targets", force: true do |t|
    t.integer  "user_id"
    t.integer  "uid",         default: 0
    t.string   "name",        default: ""
    t.string   "screen_name", default: ""
    t.integer  "nfollowers",  default: 0
    t.integer  "nfriends",    default: 0
    t.float    "f2f",         default: 0.0
    t.integer  "nfavorites",  default: 0
    t.integer  "ntweets",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "spamed",      default: false
    t.boolean  "retained",    default: false
    t.integer  "since",       default: 0
    t.integer  "nlisted",     default: 0
    t.integer  "utcoffset",   default: 0
    t.float    "tfr",         default: 0.0
    t.float    "ffr",         default: 0.0
    t.integer  "group",       default: 0
  end

  create_table "users", force: true do |t|
    t.integer  "uid",         default: 0
    t.string   "name",        default: ""
    t.string   "screen_name", default: ""
    t.string   "description", default: ""
    t.string   "location",    default: ""
    t.integer  "nfollowers",  default: 0
    t.integer  "nfriends",    default: 0
    t.integer  "nfavorites",  default: 0
    t.integer  "ntweets",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "favsme",      default: 0
    t.integer  "retsme",      default: 0
    t.integer  "mentsme",     default: 0
    t.float    "f2f",         default: 0.0
  end

end
