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

ActiveRecord::Schema.define(version: 20151118200145) do

  create_table "comments", force: :cascade do |t|
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "stand_id",   limit: 4
    t.integer  "user_id",    limit: 4
  end

  add_index "comments", ["stand_id"], name: "index_comments_on_stand_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "posters", force: :cascade do |t|
    t.string   "url",         limit: 255,   null: false
    t.integer  "user_id",     limit: 4,     null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "title",       limit: 65535
    t.text     "description", limit: 65535
    t.string   "image",       limit: 255
  end

  add_index "posters", ["url"], name: "index_posters_on_url", using: :btree
  add_index "posters", ["user_id"], name: "index_posters_on_user_id", using: :btree

  create_table "relatables", force: :cascade do |t|
    t.integer  "relating_id", limit: 4, null: false
    t.integer  "related_id",  limit: 4, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relatables", ["related_id"], name: "index_relatables_on_related_id", using: :btree
  add_index "relatables", ["relating_id", "related_id"], name: "index_relatables_on_relating_id_and_related_id", unique: true, using: :btree

  create_table "stands", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "poster_id",  limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "choice",     limit: 4
  end

  add_index "stands", ["poster_id", "user_id"], name: "index_stands_on_poster_id_and_user_id", unique: true, using: :btree
  add_index "stands", ["user_id"], name: "index_stands_on_user_id", using: :btree

  create_table "supports", force: :cascade do |t|
    t.integer  "stand_id",   limit: 4, null: false
    t.integer  "target_id",  limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "supports", ["stand_id", "target_id"], name: "index_supports_on_stand_id_and_target_id", unique: true, using: :btree
  add_index "supports", ["target_id"], name: "index_supports_on_target_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.integer  "choice",      limit: 4,     null: false
    t.integer  "stand_id",    limit: 4,     null: false
    t.integer  "previous_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "reason",      limit: 65535
  end

  add_index "versions", ["previous_id"], name: "index_versions_on_previous_id", using: :btree
  add_index "versions", ["stand_id"], name: "index_versions_on_stand_id", using: :btree

end
