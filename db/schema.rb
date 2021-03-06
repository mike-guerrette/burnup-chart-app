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

ActiveRecord::Schema.define(version: 20140414165058) do

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "release_date"
    t.date     "created_date"
  end

  create_table "scope_changes", force: true do |t|
    t.integer  "project_id"
    t.integer  "scope"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scopes", force: true do |t|
    t.integer  "project_id"
    t.date     "week_end_date"
    t.integer  "scope"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "tasktype"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "days_on_hold"
    t.text     "reason_on_hold"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

end
