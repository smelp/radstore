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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120809195848) do

  create_table "bakeries", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "bakeryorderrecipes", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "bakeryorder_id"
    t.decimal  "amount",         :default => 0.0
    t.decimal  "price",          :default => 0.0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "bakeryorderrecipes", ["bakeryorder_id"], :name => "index_bakeryorderrecipes_on_bakeryorder_id"
  add_index "bakeryorderrecipes", ["recipe_id", "bakeryorder_id"], :name => "index_bakeryorderrecipes_on_recipe_id_and_bakeryorder_id", :unique => true

  create_table "bakeryorders", :force => true do |t|
    t.string   "delivery_type"
    t.string   "state"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "bakery_id"
  end

  create_table "bills", :force => true do |t|
    t.integer  "client_id"
    t.integer  "firm_id"
    t.date     "due_date"
    t.date     "dated_at"
    t.string   "payment_condition"
    t.string   "bank"
    t.string   "info"
    t.integer  "bill_number"
    t.integer  "reference_number"
    t.decimal  "total_amount"
    t.decimal  "delay_interest"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "clientrecipes", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "client_id"
    t.decimal  "price",      :default => 0.0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "firm_id"
  end

  create_table "firms", :force => true do |t|
    t.string   "name"
    t.string   "corporate_id"
    t.string   "location"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "address"
    t.string   "account_number"
  end

  create_table "firms_users", :id => false, :force => true do |t|
    t.integer "firm_id"
    t.integer "user_id"
  end

  add_index "firms_users", ["firm_id", "user_id"], :name => "index_firms_users_on_firm_id_and_user_id", :unique => true
  add_index "firms_users", ["user_id"], :name => "index_firms_users_on_user_id"

  create_table "hasmaterials", :force => true do |t|
    t.integer  "material_id"
    t.integer  "recipe_id"
    t.float    "amount",      :default => 0.0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "hasmaterials", ["material_id", "recipe_id"], :name => "index_hasmaterials_on_material_id_and_recipe_id", :unique => true
  add_index "hasmaterials", ["recipe_id"], :name => "index_hasmaterials_on_recipe_id"

  create_table "hasrecipes", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "subrecipe_id"
    t.decimal  "amount",       :default => 0.0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "materials", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "bakery_id"
    t.decimal  "price",      :default => 0.0
  end

  create_table "orders", :force => true do |t|
    t.integer  "client_id"
    t.integer  "bill_id"
    t.integer  "suborder_id"
    t.string   "suborder_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "description"
  end

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "bakery_id"
    t.decimal  "price",      :default => 0.0
    t.decimal  "coverage",   :default => 0.0
    t.boolean  "product",    :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.integer  "primary_firm_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
