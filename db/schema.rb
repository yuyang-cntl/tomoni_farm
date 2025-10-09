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

ActiveRecord::Schema.define(version: 2025_10_09_095050) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "shipping_name", null: false
    t.string "postal_code", null: false
    t.string "address", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "broadcast_logs", force: :cascade do |t|
    t.integer "farmer_id", null: false
    t.integer "email_template_id"
    t.string "subject", null: false
    t.text "body", null: false
    t.text "recipient_ids"
    t.datetime "sent_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email_template_id"], name: "index_broadcast_logs_on_email_template_id"
    t.index ["farmer_id"], name: "index_broadcast_logs_on_farmer_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "customer_id", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_comments_on_customer_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "farmer_id"
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.string "postal_code"
    t.string "address"
    t.string "telephone_number"
    t.boolean "is_active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.integer "account_status", default: 1, null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["farmer_id"], name: "index_customers_on_farmer_id"
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "diaries", force: :cascade do |t|
    t.integer "farmer_id", null: false
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["farmer_id"], name: "index_diaries_on_farmer_id"
  end

  create_table "email_templates", force: :cascade do |t|
    t.string "title"
    t.string "subject"
    t.text "body"
    t.integer "farmer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["farmer_id"], name: "index_email_templates_on_farmer_id"
  end

  create_table "farmers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.text "introduction"
    t.string "address"
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.float "latitude", default: 0.0, null: false
    t.float "longitude", default: 0.0, null: false
    t.index ["email"], name: "index_farmers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_farmers_on_reset_password_token", unique: true
  end

  create_table "follows", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "farmer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_follows_on_customer_id"
    t.index ["farmer_id"], name: "index_follows_on_farmer_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "farmer_id", null: false
    t.string "name", null: false
    t.text "introduction", null: false
    t.string "harvest_time", null: false
    t.integer "price", null: false
    t.integer "status"
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["farmer_id"], name: "index_items_on_farmer_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_likes_on_customer_id"
    t.index ["post_id"], name: "index_likes_on_post_id"
  end

  create_table "locations", force: :cascade do |t|
    t.integer "farmer_id", null: false
    t.string "prefecture"
    t.string "city"
    t.string "street"
    t.string "postal_code"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["farmer_id"], name: "index_locations_on_farmer_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "item_id", null: false
    t.integer "customer_id", null: false
    t.integer "amount", null: false
    t.integer "price", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_order_details_on_customer_id"
    t.index ["item_id"], name: "index_order_details_on_item_id"
    t.index ["order_id"], name: "index_order_details_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "customer_id", null: false
    t.integer "shipping_cost", null: false
    t.integer "payment_method", default: 0, null: false
    t.integer "grand_total", null: false
    t.integer "amount", null: false
    t.integer "status", default: 0, null: false
    t.string "postal_code", null: false
    t.string "address", null: false
    t.string "shipping_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["item_id"], name: "index_orders_on_item_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "farmer_id", null: false
    t.integer "comment_id"
    t.integer "diary_id", null: false
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["comment_id"], name: "index_posts_on_comment_id"
    t.index ["diary_id"], name: "index_posts_on_diary_id"
    t.index ["farmer_id"], name: "index_posts_on_farmer_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "customers"
  add_foreign_key "broadcast_logs", "email_templates"
  add_foreign_key "broadcast_logs", "farmers"
  add_foreign_key "comments", "customers"
  add_foreign_key "comments", "posts"
  add_foreign_key "customers", "farmers"
  add_foreign_key "diaries", "farmers"
  add_foreign_key "email_templates", "farmers"
  add_foreign_key "follows", "customers"
  add_foreign_key "follows", "farmers"
  add_foreign_key "items", "farmers"
  add_foreign_key "likes", "customers"
  add_foreign_key "likes", "posts"
  add_foreign_key "locations", "farmers"
  add_foreign_key "order_details", "customers"
  add_foreign_key "order_details", "items"
  add_foreign_key "order_details", "orders"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "items"
  add_foreign_key "posts", "comments"
  add_foreign_key "posts", "diaries"
  add_foreign_key "posts", "farmers"
end
