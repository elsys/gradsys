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

ActiveRecord::Schema.define(version: 20140129150850) do

  create_table "commissioners_diploma_works", force: true do |t|
    t.integer "diploma_work_id"
    t.integer "commissioner_id"
  end

  create_table "diploma_works", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "diploma_supervisor_id"
    t.integer  "reviewer_id"
    t.boolean  "covenanted",            default: false
    t.boolean  "approved",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string  "grade"
    t.integer "number"
    t.integer "diploma_work_id"
    t.integer "first"
    t.integer "second"
    t.integer "third"
    t.float   "grades"
  end

  create_table "teachers", force: true do |t|
    t.string  "business"
    t.boolean "diploma_supervisor", default: false
    t.boolean "reviewer",           default: false
    t.boolean "commissioner",       default: false
  end

  create_table "users", force: true do |t|
    t.string  "name"
    t.string  "hashed_password"
    t.string  "salt"
    t.integer "heir_id"
    t.string  "heir_type"
    t.string  "user_name"
    t.string  "email"
    t.string  "access",          default: "user"
    t.boolean "active",          default: false
    t.string  "activation_code"
  end

end
