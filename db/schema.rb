# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080828135325) do

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "parent_id",   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_keywords", :id => false, :force => true do |t|
    t.integer "category_id", :limit => 11
    t.integer "keyword_id",  :limit => 11
  end

  add_index "categories_keywords", ["keyword_id", "category_id"], :name => "index_categories_keywords_on_keyword_id_and_category_id"
  add_index "categories_keywords", ["category_id"], :name => "index_categories_keywords_on_category_id"

  create_table "categories_products", :id => false, :force => true do |t|
    t.integer "category_id", :limit => 11
    t.integer "product_id",  :limit => 11
  end

  add_index "categories_products", ["category_id", "product_id"], :name => "index_categories_products_on_category_id_and_product_id"

  create_table "keywords", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords_products", :id => false, :force => true do |t|
    t.integer "keyword_id", :limit => 11
    t.integer "product_id", :limit => 11
  end

  add_index "keywords_products", ["keyword_id", "product_id"], :name => "index_keywords_products_on_keyword_id_and_product_id"
  add_index "keywords_products", ["product_id"], :name => "index_keywords_products_on_product_id"

  create_table "line_items", :force => true do |t|
    t.integer  "product_id",  :limit => 11,                                :null => false
    t.integer  "order_id",    :limit => 11,                                :null => false
    t.integer  "quantity",    :limit => 11,                                :null => false
    t.decimal  "total_price",               :precision => 11, :scale => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["order_id"], :name => "index_line_items_on_order_id"

  create_table "manufacturers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "prefix",     :limit => 20,  :default => ""
    t.string   "first_name", :limit => 50,  :default => ""
    t.string   "last_name",  :limit => 50,  :default => ""
    t.string   "postfix",    :limit => 10,  :default => ""
    t.string   "street",     :limit => 100, :default => ""
    t.string   "city",       :limit => 50,  :default => ""
    t.string   "zip",        :limit => 6,   :default => ""
    t.string   "phone",      :limit => 18,  :default => ""
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "products", :force => true do |t|
    t.string   "title",                                                        :default => "",  :null => false
    t.text     "description"
    t.decimal  "price",                         :precision => 11, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "for_sale"
    t.integer  "manufacturer_id", :limit => 11
  end

  add_index "products", ["manufacturer_id"], :name => "index_products_on_manufacturer_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                          :default => ""
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "prefix",          :limit => 20,  :default => ""
    t.string   "first_name",      :limit => 50,  :default => ""
    t.string   "last_name",       :limit => 50,  :default => ""
    t.string   "postfix",         :limit => 10,  :default => ""
    t.string   "street",          :limit => 100, :default => ""
    t.string   "city",            :limit => 50,  :default => ""
    t.string   "zip",             :limit => 6,   :default => ""
    t.string   "phone",           :limit => 18,  :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
