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

ActiveRecord::Schema.define(version: 2021_10_10_165236) do

  create_table "employers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_employers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employers_on_reset_password_token", unique: true
  end

  create_table "perfil_workers", force: :cascade do |t|
    t.string "full_name"
    t.string "name"
    t.date "birthdate"
    t.string "qualification"
    t.string "background"
    t.string "expertise"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "worker_id", null: false
    t.index ["worker_id"], name: "index_perfil_workers_on_worker_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.decimal "max_per_hour"
    t.date "deadline"
    t.string "place"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.integer "employer_id", null: false
    t.index ["employer_id"], name: "index_projects_on_employer_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.string "description"
    t.decimal "hourly_value"
    t.integer "hours_per_week"
    t.date "date_close"
    t.integer "project_id", null: false
    t.integer "worker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_proposals_on_project_id"
    t.index ["worker_id"], name: "index_proposals_on_worker_id"
  end

  create_table "workers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_workers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_workers_on_reset_password_token", unique: true
  end

  add_foreign_key "perfil_workers", "workers"
  add_foreign_key "projects", "employers"
  add_foreign_key "proposals", "projects"
  add_foreign_key "proposals", "workers"
end
