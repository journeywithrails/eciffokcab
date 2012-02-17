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

ActiveRecord::Schema.define(:version => 20110714165327) do

  create_table "comments", :force => true do |t|
    t.string   "subject"
    t.string   "body"
    t.string   "tech"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configurations", :force => true do |t|
    t.integer  "taxrate"
    t.string   "business_name"
    t.string   "admin_user"
    t.string   "admin_pass"
    t.text     "invoice_footer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "mobile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "invoices", :force => true do |t|
    t.string   "number"
    t.string   "paid"
    t.string   "date"
    t.string   "date_received"
    t.string   "notax"
    t.string   "audit"
    t.string   "timestamp"
    t.string   "check_number"
    t.string   "saved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "bizx"
  end

  create_table "items", :force => true do |t|
    t.string   "requestedon"
    t.string   "ticketnum"
    t.string   "parturl"
    t.string   "shipping"
    t.string   "deststore"
    t.string   "orderedby"
    t.string   "orderedon"
    t.string   "trackingnum"
    t.string   "receivedon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "linetypes", :force => true do |t|
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

  create_table "tickets", :force => true do |t|
    t.string   "number"
    t.string   "subject"
    t.date     "created"
    t.string   "status"
    t.string   "problem_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "upgrades", :force => true do |t|
    t.string   "pc_desc"
    t.date     "pc_age"
    t.string   "operating_system"
    t.integer  "memory"
    t.integer  "disk_size"
    t.integer  "disk_used_percent"
    t.string   "av_software"
    t.string   "backups"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
