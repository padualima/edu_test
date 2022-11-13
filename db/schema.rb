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

ActiveRecord::Schema[7.0].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "document", limit: 14
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "cpf", limit: 11
    t.string "ide", limit: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id", "ide"], name: "index_members_on_id_and_ide", unique: true
  end

  create_table "node_groups", force: :cascade do |t|
    t.string "slug", limit: 4, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
