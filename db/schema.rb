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

ActiveRecord::Schema.define(version: 20150925021103) do

  create_table "auth_groups", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "auth_groups", ["name"], name: "index_auth_groups_on_name"

  create_table "auth_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "auth_group_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "auth_memberships", ["auth_group_id"], name: "index_auth_memberships_on_auth_group_id"
  add_index "auth_memberships", ["user_id", "auth_group_id"], name: "index_auth_memberships_on_user_id_and_auth_group_id", unique: true
  add_index "auth_memberships", ["user_id"], name: "index_auth_memberships_on_user_id"

  create_table "ingredients", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.text     "description"
  end

  create_table "quantities", force: :cascade do |t|
    t.string   "name"
    t.float    "multiplier"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "quantity_type"
    t.string   "abbreviation"
  end

  add_index "quantities", ["name"], name: "index_quantities_on_name"

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "quantity_id"
    t.float    "quantity_multiplier"
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "directions"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "password_digest"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "username"
    t.text     "bio"
    t.string   "firstname"
    t.string   "lastname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
