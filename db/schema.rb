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

ActiveRecord::Schema.define(:version => 20120708072930) do

  create_table "bakeries", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "bakerybills", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "bakery_id"
  end

  create_table "billrecipes", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "bakerybill_id"
    t.float    "amount",        :default => 0.0
    t.float    "price",         :default => 0.0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "billrecipes", ["bakerybill_id"], :name => "index_billrecipes_on_bakerybill_id"
  add_index "billrecipes", ["recipe_id", "bakerybill_id"], :name => "index_billrecipes_on_recipe_id_and_bakerybill_id", :unique => true

  create_table "bills", :force => true do |t|
    t.string   "delivery_type"
    t.date     "due_date"
    t.float    "total_amount"
    t.integer  "subbill_id"
    t.string   "subbill_type"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "client_id"
    t.string   "state",         :default => "Tilattu"
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
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
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
    t.float    "amount",       :default => 0.0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "materials", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "bakery_id"
    t.float    "price",      :default => 0.0
  end

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "bakery_id"
    t.float    "price",      :default => 0.0
    t.float    "coverage",   :default => 0.0
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
