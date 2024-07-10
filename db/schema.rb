# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_10_020408) do
  create_table "cart_items", force: :cascade do |t|
    t.integer "cart_id"
    t.integer "teddy_type_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["teddy_type_id"], name: "index_cart_items_on_teddy_type_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_carts_on_customer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.string "phone_number"
    t.string "province"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "teddy_type_id"
    t.integer "quantity"
    t.decimal "item_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["teddy_type_id"], name: "index_order_items_on_teddy_type_id"
  end

  create_table "order_taxes", force: :cascade do |t|
    t.integer "order_id"
    t.integer "tax_id"
    t.decimal "tax_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_taxes_on_order_id"
    t.index ["tax_id"], name: "index_order_taxes_on_tax_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.boolean "status"
    t.decimal "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.string "province"
    t.string "tax_type"
    t.decimal "tax_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teddy_types", force: :cascade do |t|
    t.string "teddy_name"
    t.text "description"
    t.decimal "price"
    t.integer "stock_quantity"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_teddy_types_on_category_id"
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "teddy_types"
  add_foreign_key "carts", "customers"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "teddy_types"
  add_foreign_key "order_taxes", "orders"
  add_foreign_key "order_taxes", "taxes"
  add_foreign_key "orders", "customers"
  add_foreign_key "teddy_types", "categories"
end
