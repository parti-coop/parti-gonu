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

ActiveRecord::Schema.define(version: 20151201210656) do

  create_table "comments", force: :cascade do |t|
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "stand_id",   limit: 4
    t.integer  "user_id",    limit: 4
  end

  add_index "comments", ["stand_id"], name: "index_comments_on_stand_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "posters", force: :cascade do |t|
    t.string   "url",                     limit: 255
    t.integer  "user_id",                 limit: 4,                   null: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.text     "title",                   limit: 65535
    t.text     "description",             limit: 65535
    t.string   "image",                   limit: 255
    t.text     "question",                                            null: false
    t.integer  "source_id"
    t.integer  "up",                                    default: 0
    t.integer  "down",                                  default: 0
    t.integer  "up_count",                              default: 0
    t.integer  "down_count",                            default: 0
    t.string   "tags"
    t.integer  "cached_votes_total",                    default: 0
    t.integer  "cached_votes_score",                    default: 0
    t.integer  "cached_votes_up",                       default: 0
    t.integer  "cached_votes_down",                     default: 0
    t.integer  "cached_weighted_score",                 default: 0
    t.integer  "cached_weighted_total",                 default: 0
    t.float    "cached_weighted_average",               default: 0.0
  end

  add_index "posters", ["cached_votes_down"], name: "index_posters_on_cached_votes_down"
  add_index "posters", ["cached_votes_score"], name: "index_posters_on_cached_votes_score"
  add_index "posters", ["cached_votes_total"], name: "index_posters_on_cached_votes_total"
  add_index "posters", ["cached_votes_up"], name: "index_posters_on_cached_votes_up"
  add_index "posters", ["cached_weighted_average"], name: "index_posters_on_cached_weighted_average"
  add_index "posters", ["cached_weighted_score"], name: "index_posters_on_cached_weighted_score"
  add_index "posters", ["cached_weighted_total"], name: "index_posters_on_cached_weighted_total"
  add_index "posters", ["source_id"], name: "index_posters_on_source_id"
  add_index "posters", ["url"], name: "index_posters_on_url"
  add_index "posters", ["user_id"], name: "index_posters_on_user_id"

  create_table "relatables", force: :cascade do |t|
    t.integer  "relating_id", limit: 4, null: false
    t.integer  "related_id",  limit: 4, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relatables", ["related_id"], name: "index_relatables_on_related_id"
  add_index "relatables", ["relating_id", "related_id"], name: "index_relatables_on_relating_id_and_related_id", unique: true

  create_table "sources", force: :cascade do |t|
    t.string   "url",         null: false
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sources", ["url"], name: "index_sources_on_url", unique: true

  create_table "stands", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "poster_id",  limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "choice",     limit: 4
  end

  add_index "stands", ["poster_id", "user_id"], name: "index_stands_on_poster_id_and_user_id", unique: true
  add_index "stands", ["user_id"], name: "index_stands_on_user_id"

  create_table "supports", force: :cascade do |t|
    t.integer  "stand_id",   limit: 4, null: false
    t.integer  "target_id",  limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "supports", ["stand_id", "target_id"], name: "index_supports_on_stand_id_and_target_id", unique: true
  add_index "supports", ["target_id"], name: "index_supports_on_target_id"

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

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: :cascade do |t|
    t.integer  "choice",      limit: 4,     null: false
    t.integer  "stand_id",    limit: 4,     null: false
    t.integer  "previous_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "reason",      limit: 65535
  end

  add_index "versions", ["previous_id"], name: "index_versions_on_previous_id"
  add_index "versions", ["stand_id"], name: "index_versions_on_stand_id"

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
