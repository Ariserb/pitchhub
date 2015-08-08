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

ActiveRecord::Schema.define(version: 20150807071022) do

  create_table "discourses", force: :cascade do |t|
    t.string   "object_id",               null: false
    t.string   "pitch_card_id",           null: false
    t.string   "author_id",               null: false
    t.string   "discourse_type",          null: false
    t.string   "message_type",            null: false
    t.string   "comment",                 null: false
    t.string   "content"
    t.string   "author_name",             null: false
    t.string   "pitch_point_id",          null: false
    t.string   "pitch_point_name",        null: false
    t.string   "initiator_id",            null: false
    t.string   "identity_scope",          null: false
    t.string   "content_scope",           null: false
    t.string   "initiator_content_scope"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pitch_cards", force: :cascade do |t|
    t.string   "object_id",      null: false
    t.string   "status"
    t.string   "initiator_id"
    t.string   "identity_scope"
    t.string   "content_scope"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pitch_points", force: :cascade do |t|
    t.string  "object_id",     null: false
    t.string  "pitch_card_id", null: false
    t.string  "name"
    t.boolean "selected"
    t.string  "value"
  end

end
