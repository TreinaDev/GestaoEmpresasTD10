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

ActiveRecord::Schema[7.0].define(version: 2023_07_03_215202) do
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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "registration_number"
    t.string "address"
    t.string "phone_number"
    t.string "email"
    t.string "domain"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["registration_number"], name: "index_companies_on_registration_number", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "code", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_departments_on_code", unique: true
    t.index ["company_id"], name: "index_departments_on_company_id"
  end

  create_table "employee_profiles", force: :cascade do |t|
    t.string "name"
    t.string "social_name"
    t.string "cpf"
    t.string "rg"
    t.string "address"
    t.string "email"
    t.string "phone_number"
    t.integer "status"
    t.date "birth_date"
    t.date "admission_date"
    t.date "dismissal_date"
    t.integer "marital_status"
    t.integer "department_id", null: false
    t.integer "user_id"
    t.integer "position_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "card_status", default: false
    t.index ["cpf"], name: "index_employee_profiles_on_cpf", unique: true
    t.index ["department_id"], name: "index_employee_profiles_on_department_id"
    t.index ["email"], name: "index_employee_profiles_on_email", unique: true
    t.index ["position_id"], name: "index_employee_profiles_on_position_id"
    t.index ["rg"], name: "index_employee_profiles_on_rg", unique: true
    t.index ["user_id"], name: "index_employee_profiles_on_user_id"
  end

  create_table "manager_emails", force: :cascade do |t|
    t.string "email"
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.boolean "status", default: true
    t.index ["company_id"], name: "index_manager_emails_on_company_id"
    t.index ["created_by_id"], name: "index_manager_emails_on_created_by_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "code"
    t.integer "card_type_id"
    t.integer "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "standard_recharge", default: 0.0
    t.index ["code"], name: "index_positions_on_code", unique: true
    t.index ["department_id"], name: "index_positions_on_department_id"
  end

  create_table "recharge_histories", force: :cascade do |t|
    t.float "value"
    t.integer "created_by_id", null: false
    t.integer "employee_profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_recharge_histories_on_created_by_id"
    t.index ["employee_profile_id"], name: "index_recharge_histories_on_employee_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cpf"
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "departments", "companies"
  add_foreign_key "employee_profiles", "departments"
  add_foreign_key "employee_profiles", "positions"
  add_foreign_key "employee_profiles", "users"
  add_foreign_key "manager_emails", "users", column: "created_by_id"
  add_foreign_key "positions", "departments"
  add_foreign_key "recharge_histories", "employee_profiles"
  add_foreign_key "recharge_histories", "users", column: "created_by_id"
end
