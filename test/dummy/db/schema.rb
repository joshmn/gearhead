# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_11_231456) do

  create_table "comments", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "person_id", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_comments_on_person_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "age", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_people_on_email"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "person_id", null: false
    t.datetime "published_at"
    t.boolean "private", default: false, null: false
    t.text "content"
    t.text "tags", default: "[]"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_posts_on_person_id"
    t.index ["published_at"], name: "index_posts_on_published_at"
  end

  add_foreign_key "comments", "people"
  add_foreign_key "comments", "posts"
  add_foreign_key "posts", "people"
end
