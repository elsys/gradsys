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

ActiveRecord::Schema.define(version: 20140309082712) do

  create_table "assembles", force: true do |t|
    t.string  "round"
    t.string  "committee_start_date"
    t.string  "committee_end_date"
    t.integer "year_for_registration"
    t.integer "year_for_assembling"
  end

  create_table "commissioners_committees", force: true do |t|
    t.integer "committee_id"
    t.integer "commissioner_id"
  end

  create_table "committees", force: true do |t|
    t.string  "date"
    t.integer "president_id"
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
    t.boolean  "checkout"
    t.integer  "committee_id"
    t.integer  "diplomants_number"
    t.integer  "year"
  end

  create_table "diploma_works_tags", force: true do |t|
    t.integer "tag_id"
    t.integer "diploma_work_id"
  end

  create_table "students", force: true do |t|
    t.string  "grade"
    t.integer "number"
    t.integer "diploma_work_id"
    t.integer "first"
    t.integer "second"
    t.integer "third"
    t.float   "grades"
    t.integer "year"
    t.integer "egn"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags_teachers", force: true do |t|
    t.integer "tag_id"
    t.integer "teacher_id"
  end

  create_table "teachers", force: true do |t|
    t.string  "business"
    t.boolean "diploma_supervisor", default: false
    t.boolean "reviewer",           default: false
    t.boolean "commissioner",       default: false
    t.string  "commissioner_dates"
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
    t.boolean "lost_password",   default: false
    t.string  "skype"
    t.integer "gsm"
  end

end
