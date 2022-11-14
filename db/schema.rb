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

ActiveRecord::Schema[7.0].define(version: 2022_11_14_140908) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "document", limit: 14
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expense_categories", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expense_companies", force: :cascade do |t|
    t.bigint "expense_id", null: false
    t.bigint "company_id", null: false
    t.string "ide_document"
    t.string "description"
    t.string "exact_description"
    t.integer "value_cents"
    t.date "issued_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_expense_companies_on_company_id"
    t.index ["expense_id"], name: "index_expense_companies_on_expense_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "portfolio_id", null: false
    t.integer "amount_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "expense_category_id", null: false
    t.index ["expense_category_id"], name: "index_expenses_on_expense_category_id"
    t.index ["portfolio_id"], name: "index_expenses_on_portfolio_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "cpf", limit: 11
    t.string "ide", limit: 40
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id", "ide"], name: "index_members_on_id_and_ide", unique: true
  end

  create_table "node_groups", force: :cascade do |t|
    t.string "slug", limit: 4, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.integer "kind", limit: 2
    t.index ["ancestry"], name: "index_node_groups_on_ancestry"
  end

  create_table "portfolios", force: :cascade do |t|
    t.bigint "node_group_id", null: false
    t.bigint "member_id", null: false
    t.string "uf", limit: 2
    t.string "parliamentary_number"
    t.string "legislature", limit: 4
    t.string "legislature_code", limit: 40
    t.string "political_party", limit: 40
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expenses_amount_cents"
    t.index ["member_id"], name: "index_portfolios_on_member_id"
    t.index ["node_group_id"], name: "index_portfolios_on_node_group_id"
  end

  add_foreign_key "expense_companies", "companies"
  add_foreign_key "expense_companies", "expenses"
  add_foreign_key "expenses", "expense_categories"
  add_foreign_key "expenses", "portfolios"
  add_foreign_key "portfolios", "members"
  add_foreign_key "portfolios", "node_groups"
end
