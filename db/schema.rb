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

ActiveRecord::Schema.define(version: 20161213055121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addendum_details", force: :cascade do |t|
    t.integer  "addendum_id"
    t.integer  "product_id"
    t.float    "quantity"
    t.float    "unit_price"
    t.float    "subtotal"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["addendum_id"], name: "index_addendum_details_on_addendum_id", using: :btree
    t.index ["product_id"], name: "index_addendum_details_on_product_id", using: :btree
  end

  create_table "addendum_documents", force: :cascade do |t|
    t.integer  "addendum_id"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["addendum_id"], name: "index_addendum_documents_on_addendum_id", using: :btree
  end

  create_table "addendums", force: :cascade do |t|
    t.integer  "contract_id"
    t.string   "addendum_number"
    t.float    "ammount"
    t.date     "date"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "updated",         default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["contract_id"], name: "index_addendums_on_contract_id", using: :btree
  end

  create_table "businesses", force: :cascade do |t|
    t.string   "name"
    t.string   "ruc"
    t.string   "billing_address"
    t.string   "delivery_address"
    t.string   "telephone"
    t.string   "contact"
    t.boolean  "active",           default: true
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "ruc"
    t.string   "billing_address"
    t.string   "delivery_address"
    t.string   "telephone"
    t.string   "contact"
    t.boolean  "active",           default: true
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "contract_details", force: :cascade do |t|
    t.integer  "contract_id"
    t.integer  "product_id"
    t.float    "quantity"
    t.float    "pending"
    t.float    "unit_price"
    t.float    "subtotal"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["contract_id"], name: "index_contract_details_on_contract_id", using: :btree
    t.index ["product_id"], name: "index_contract_details_on_product_id", using: :btree
  end

  create_table "contract_documents", force: :cascade do |t|
    t.integer  "contract_id"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["contract_id"], name: "index_contract_documents_on_contract_id", using: :btree
  end

  create_table "contracts", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "business_id"
    t.string   "contract_number"
    t.date     "date"
    t.date     "start_date"
    t.date     "end_date"
    t.float    "final_price"
    t.float    "credit"
    t.boolean  "active",          default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["business_id"], name: "index_contracts_on_business_id", using: :btree
    t.index ["client_id"], name: "index_contracts_on_client_id", using: :btree
  end

  create_table "control_guide_details", force: :cascade do |t|
    t.integer  "control_guide_id"
    t.integer  "product_id"
    t.float    "quantity"
    t.float    "unit_price"
    t.float    "subtotal"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["control_guide_id"], name: "index_control_guide_details_on_control_guide_id", using: :btree
    t.index ["product_id"], name: "index_control_guide_details_on_product_id", using: :btree
  end

  create_table "control_guides", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "client_id"
    t.integer  "driver_id"
    t.integer  "vehicle_id"
    t.integer  "sales_order_id"
    t.string   "control_guide_number"
    t.string   "initial_point"
    t.string   "final_point"
    t.date     "date"
    t.float    "ammount"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["business_id"], name: "index_control_guides_on_business_id", using: :btree
    t.index ["client_id"], name: "index_control_guides_on_client_id", using: :btree
    t.index ["driver_id"], name: "index_control_guides_on_driver_id", using: :btree
    t.index ["sales_order_id"], name: "index_control_guides_on_sales_order_id", using: :btree
    t.index ["vehicle_id"], name: "index_control_guides_on_vehicle_id", using: :btree
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "name"
    t.string   "license"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_details", force: :cascade do |t|
    t.integer  "invoice_id"
    t.integer  "product_id"
    t.float    "quantity"
    t.float    "unit_price"
    t.float    "subtotal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_invoice_details_on_invoice_id", using: :btree
    t.index ["product_id"], name: "index_invoice_details_on_product_id", using: :btree
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "client_id"
    t.integer  "sales_order_id"
    t.string   "invoice_number"
    t.date     "date"
    t.float    "ammount"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["business_id"], name: "index_invoices_on_business_id", using: :btree
    t.index ["client_id"], name: "index_invoices_on_client_id", using: :btree
    t.index ["sales_order_id"], name: "index_invoices_on_sales_order_id", using: :btree
  end

  create_table "product_lots", force: :cascade do |t|
    t.float    "quantity"
    t.string   "sanitary_registry"
    t.date     "due_date"
    t.string   "lot_number"
    t.date     "production_date"
    t.integer  "product_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["product_id"], name: "index_product_lots_on_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "unit_of_measurement"
    t.string   "description"
    t.string   "trademark"
    t.string   "sku"
    t.boolean  "igv",                 default: false
    t.integer  "category_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
  end

  create_table "purchase_order_details", force: :cascade do |t|
    t.integer  "purchase_order_id"
    t.integer  "product_id"
    t.float    "quantity"
    t.float    "pending"
    t.float    "unit_price"
    t.float    "subtotal"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["product_id"], name: "index_purchase_order_details_on_product_id", using: :btree
    t.index ["purchase_order_id"], name: "index_purchase_order_details_on_purchase_order_id", using: :btree
  end

  create_table "purchase_order_documents", force: :cascade do |t|
    t.integer  "purchase_order_id"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["purchase_order_id"], name: "index_purchase_order_documents_on_purchase_order_id", using: :btree
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.integer  "supplier_id"
    t.integer  "business_id"
    t.string   "order_number"
    t.date     "date"
    t.date     "order_date"
    t.date     "delivery_date"
    t.string   "billing_address"
    t.string   "delivery_address"
    t.float    "ammount"
    t.boolean  "registered",       default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["business_id"], name: "index_purchase_orders_on_business_id", using: :btree
    t.index ["supplier_id"], name: "index_purchase_orders_on_supplier_id", using: :btree
  end

  create_table "remission_guide_details", force: :cascade do |t|
    t.integer  "remission_guide_id"
    t.integer  "product_id"
    t.float    "quantity"
    t.float    "unit_price"
    t.float    "subtotal"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["product_id"], name: "index_remission_guide_details_on_product_id", using: :btree
    t.index ["remission_guide_id"], name: "index_remission_guide_details_on_remission_guide_id", using: :btree
  end

  create_table "remission_guides", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "client_id"
    t.integer  "driver_id"
    t.integer  "vehicle_id"
    t.integer  "sales_order_id"
    t.string   "remission_guide_number"
    t.string   "initial_point"
    t.string   "final_point"
    t.date     "date"
    t.float    "ammount"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["business_id"], name: "index_remission_guides_on_business_id", using: :btree
    t.index ["client_id"], name: "index_remission_guides_on_client_id", using: :btree
    t.index ["driver_id"], name: "index_remission_guides_on_driver_id", using: :btree
    t.index ["sales_order_id"], name: "index_remission_guides_on_sales_order_id", using: :btree
    t.index ["vehicle_id"], name: "index_remission_guides_on_vehicle_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "sales_order_details", force: :cascade do |t|
    t.integer  "sales_order_id"
    t.integer  "product_id"
    t.float    "quantity"
    t.float    "unit_price"
    t.float    "subtotal"
    t.float    "pending_rg"
    t.float    "pending_cg"
    t.float    "pending_inv"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["product_id"], name: "index_sales_order_details_on_product_id", using: :btree
    t.index ["sales_order_id"], name: "index_sales_order_details_on_sales_order_id", using: :btree
  end

  create_table "sales_order_documents", force: :cascade do |t|
    t.integer  "sales_order_id"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["sales_order_id"], name: "index_sales_order_documents_on_sales_order_id", using: :btree
  end

  create_table "sales_orders", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "client_id"
    t.integer  "contract_id"
    t.string   "sales_order_number"
    t.string   "siaf_number"
    t.date     "date"
    t.string   "billing_address"
    t.string   "delivery_address"
    t.date     "order_date"
    t.date     "delivery_date"
    t.float    "ammount"
    t.integer  "status",             default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["business_id"], name: "index_sales_orders_on_business_id", using: :btree
    t.index ["client_id"], name: "index_sales_orders_on_client_id", using: :btree
  end

  create_table "settings", force: :cascade do |t|
    t.integer  "expiration_alert"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "ruc"
    t.string   "address"
    t.string   "telephone"
    t.string   "contact"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "roles_mask"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "vehicles", force: :cascade do |t|
    t.string   "plate"
    t.string   "trademark"
    t.string   "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addendum_details", "addendums"
  add_foreign_key "addendum_details", "products"
  add_foreign_key "addendum_documents", "addendums"
  add_foreign_key "addendums", "contracts"
  add_foreign_key "contract_details", "contracts"
  add_foreign_key "contract_details", "products"
  add_foreign_key "contract_documents", "contracts"
  add_foreign_key "contracts", "businesses"
  add_foreign_key "contracts", "clients"
  add_foreign_key "control_guide_details", "control_guides"
  add_foreign_key "control_guide_details", "products"
  add_foreign_key "control_guides", "businesses"
  add_foreign_key "control_guides", "clients"
  add_foreign_key "control_guides", "drivers"
  add_foreign_key "control_guides", "sales_orders"
  add_foreign_key "control_guides", "vehicles"
  add_foreign_key "invoice_details", "invoices"
  add_foreign_key "invoice_details", "products"
  add_foreign_key "invoices", "businesses"
  add_foreign_key "invoices", "clients"
  add_foreign_key "invoices", "sales_orders"
  add_foreign_key "product_lots", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "purchase_order_details", "products"
  add_foreign_key "purchase_order_details", "purchase_orders"
  add_foreign_key "purchase_order_documents", "purchase_orders"
  add_foreign_key "purchase_orders", "businesses"
  add_foreign_key "purchase_orders", "suppliers"
  add_foreign_key "remission_guide_details", "products"
  add_foreign_key "remission_guide_details", "remission_guides"
  add_foreign_key "remission_guides", "businesses"
  add_foreign_key "remission_guides", "clients"
  add_foreign_key "remission_guides", "drivers"
  add_foreign_key "remission_guides", "sales_orders"
  add_foreign_key "remission_guides", "vehicles"
  add_foreign_key "sales_order_details", "products"
  add_foreign_key "sales_order_details", "sales_orders"
  add_foreign_key "sales_order_documents", "sales_orders"
  add_foreign_key "sales_orders", "businesses"
  add_foreign_key "sales_orders", "clients"
end
