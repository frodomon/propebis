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

ActiveRecord::Schema.define(version: 20161030150645) do

  create_table "addendum_details", force: :cascade do |t|
    t.integer  "addendum_id", limit: 4
    t.integer  "product_id",  limit: 4
    t.float    "quantity",    limit: 24
    t.float    "unit_price",  limit: 24
    t.float    "subtotal",    limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "addendum_details", ["addendum_id"], name: "index_addendum_details_on_addendum_id", using: :btree
  add_index "addendum_details", ["product_id"], name: "index_addendum_details_on_product_id", using: :btree

  create_table "addendum_documents", force: :cascade do |t|
    t.integer  "addendum_id",           limit: 4
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 4
    t.datetime "document_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "addendum_documents", ["addendum_id"], name: "index_addendum_documents_on_addendum_id", using: :btree

  create_table "addendums", force: :cascade do |t|
    t.integer  "contract_id",     limit: 4
    t.string   "addendum_number", limit: 255
    t.float    "ammount",         limit: 24
    t.date     "date"
    t.boolean  "updated",         limit: 1,   default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "addendums", ["contract_id"], name: "index_addendums_on_contract_id", using: :btree

  create_table "businesses", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "ruc",              limit: 255
    t.string   "billing_address",  limit: 255
    t.string   "delivery_address", limit: 255
    t.string   "telephone",        limit: 255
    t.string   "contact",          limit: 255
    t.boolean  "active",           limit: 1,   default: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "ruc",              limit: 255
    t.string   "billing_address",  limit: 255
    t.string   "delivery_address", limit: 255
    t.string   "telephone",        limit: 255
    t.string   "contact",          limit: 255
    t.boolean  "active",           limit: 1,   default: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "contract_details", force: :cascade do |t|
    t.integer  "contract_id", limit: 4
    t.integer  "product_id",  limit: 4
    t.float    "quantity",    limit: 24
    t.float    "unit_price",  limit: 24
    t.float    "subtotal",    limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "contract_details", ["contract_id"], name: "index_contract_details_on_contract_id", using: :btree
  add_index "contract_details", ["product_id"], name: "index_contract_details_on_product_id", using: :btree

  create_table "contract_documents", force: :cascade do |t|
    t.integer  "contract_id",           limit: 4
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 4
    t.datetime "document_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "contract_documents", ["contract_id"], name: "index_contract_documents_on_contract_id", using: :btree

  create_table "contracts", force: :cascade do |t|
    t.integer  "client_id",       limit: 4
    t.integer  "business_id",     limit: 4
    t.string   "contract_number", limit: 255
    t.date     "date"
    t.date     "start_date"
    t.date     "end_date"
    t.float    "final_price",     limit: 24
    t.float    "credit",          limit: 24
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "contracts", ["business_id"], name: "index_contracts_on_business_id", using: :btree
  add_index "contracts", ["client_id"], name: "index_contracts_on_client_id", using: :btree

  create_table "drivers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "license",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "product_lots", force: :cascade do |t|
    t.float    "quantity",          limit: 53
    t.string   "sanitary_registry", limit: 255
    t.date     "due_date"
    t.string   "lot_number",        limit: 255
    t.date     "production_date"
    t.integer  "product_id",        limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "product_lots", ["product_id"], name: "index_product_lots_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "unit_of_measurement", limit: 255
    t.string   "description",         limit: 255
    t.string   "trademark",           limit: 255
    t.integer  "category_id",         limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "purchase_order_details", force: :cascade do |t|
    t.integer  "purchase_order_id", limit: 4
    t.integer  "product_id",        limit: 4
    t.float    "quantity",          limit: 24
    t.float    "unit_price",        limit: 24
    t.float    "subtotal",          limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "purchase_order_details", ["product_id"], name: "index_purchase_order_details_on_product_id", using: :btree
  add_index "purchase_order_details", ["purchase_order_id"], name: "index_purchase_order_details_on_purchase_order_id", using: :btree

  create_table "purchase_order_documents", force: :cascade do |t|
    t.integer  "purchase_order_id",     limit: 4
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 4
    t.datetime "document_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "purchase_order_documents", ["purchase_order_id"], name: "index_purchase_order_documents_on_purchase_order_id", using: :btree

  create_table "purchase_orders", force: :cascade do |t|
    t.integer  "supplier_id",      limit: 4
    t.integer  "business_id",      limit: 4
    t.string   "order_number",     limit: 255
    t.date     "date"
    t.date     "order_date"
    t.date     "delivery_date"
    t.string   "billing_address",  limit: 255
    t.string   "delivery_address", limit: 255
    t.float    "ammount",          limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "purchase_orders", ["business_id"], name: "index_purchase_orders_on_business_id", using: :btree
  add_index "purchase_orders", ["supplier_id"], name: "index_purchase_orders_on_supplier_id", using: :btree

  create_table "remission_guide_details", force: :cascade do |t|
    t.integer  "remission_guide_id", limit: 4
    t.integer  "product_id",         limit: 4
    t.float    "quantity",           limit: 24
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "remission_guide_details", ["product_id"], name: "index_remission_guide_details_on_product_id", using: :btree
  add_index "remission_guide_details", ["remission_guide_id"], name: "index_remission_guide_details_on_remission_guide_id", using: :btree

  create_table "remission_guides", force: :cascade do |t|
    t.integer  "business_id",            limit: 4
    t.integer  "client_id",              limit: 4
    t.integer  "driver_id",              limit: 4
    t.integer  "vehicle_id",             limit: 4
    t.string   "remission_guide_number", limit: 255
    t.string   "initial_point",          limit: 255
    t.string   "final_point",            limit: 255
    t.date     "date"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "remission_guides", ["business_id"], name: "index_remission_guides_on_business_id", using: :btree
  add_index "remission_guides", ["client_id"], name: "index_remission_guides_on_client_id", using: :btree
  add_index "remission_guides", ["driver_id"], name: "index_remission_guides_on_driver_id", using: :btree
  add_index "remission_guides", ["vehicle_id"], name: "index_remission_guides_on_vehicle_id", using: :btree

  create_table "sales_order_details", force: :cascade do |t|
    t.integer  "sales_order_id", limit: 4
    t.integer  "product_id",     limit: 4
    t.float    "quantity",       limit: 24
    t.float    "unit_price",     limit: 24
    t.float    "subtotal",       limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "sales_order_details", ["product_id"], name: "index_sales_order_details_on_product_id", using: :btree
  add_index "sales_order_details", ["sales_order_id"], name: "index_sales_order_details_on_sales_order_id", using: :btree

  create_table "sales_order_documents", force: :cascade do |t|
    t.integer  "sales_order_id",        limit: 4
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 4
    t.datetime "document_updated_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "sales_order_documents", ["sales_order_id"], name: "index_sales_order_documents_on_sales_order_id", using: :btree

  create_table "sales_orders", force: :cascade do |t|
    t.integer  "business_id",        limit: 4
    t.integer  "client_id",          limit: 4
    t.integer  "contract_id",        limit: 4
    t.string   "sales_order_number", limit: 255
    t.date     "date"
    t.string   "billing_address",    limit: 255
    t.string   "delivery_address",   limit: 255
    t.date     "order_date"
    t.date     "delivery_date"
    t.float    "ammount",            limit: 24
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "sales_orders", ["business_id"], name: "index_sales_orders_on_business_id", using: :btree
  add_index "sales_orders", ["client_id"], name: "index_sales_orders_on_client_id", using: :btree
  add_index "sales_orders", ["contract_id"], name: "index_sales_orders_on_contract_id", using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "ruc",        limit: 255
    t.string   "address",    limit: 255
    t.string   "telephone",  limit: 255
    t.string   "contact",    limit: 255
    t.boolean  "active",     limit: 1,   default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string   "plate",      limit: 255
    t.string   "trademark",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
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
  add_foreign_key "product_lots", "products"
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
  add_foreign_key "remission_guides", "vehicles"
  add_foreign_key "sales_order_details", "products"
  add_foreign_key "sales_order_details", "sales_orders"
  add_foreign_key "sales_order_documents", "sales_orders"
  add_foreign_key "sales_orders", "businesses"
  add_foreign_key "sales_orders", "clients"
  add_foreign_key "sales_orders", "contracts"
end
