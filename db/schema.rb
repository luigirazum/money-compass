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

ActiveRecord::Schema[7.1].define(version: 2024_02_29_084926) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 35, null: false
    t.string "icon", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "name"], name: "unique_category_names_by_user", unique: true
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "category_payments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id", null: false
    t.bigint "payment_id", null: false
    t.index ["category_id", "payment_id"], name: "unique_payments_by_category", unique: true
    t.index ["category_id"], name: "category_with_payments"
    t.index ["payment_id"], name: "payment_with_category"
  end

  create_table "payments", force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.decimal "amount", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id", null: false
    t.index ["author_id"], name: "index_payments_on_author_id"
    t.index ["name"], name: "index_payments_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "unique_user_names", unique: true
  end

  add_foreign_key "categories", "users"
  add_foreign_key "category_payments", "categories"
  add_foreign_key "category_payments", "payments"
  add_foreign_key "payments", "users", column: "author_id"
end
