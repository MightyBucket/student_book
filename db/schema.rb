# encoding: UTF-8

ActiveRecord::Schema.define(version: 20160415101643) do

  create_table "groups", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "color_t"
    t.integer  "user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string   "forename"
    t.string   "surname"
    t.string   "grade_predicted"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "group_id"
  end

  add_index "students", ["group_id"], name: "index_students_on_group_id"

  create_table "user_files", force: :cascade do |t|
    t.string   "name"
    t.string   "attachment"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "student_name"
    t.integer  "group_id"
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
