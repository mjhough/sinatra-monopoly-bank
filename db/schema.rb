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

ActiveRecord::Schema.define(version: 20171130034522) do

  create_table "auctions", force: :cascade do |t|
    t.integer "time_limit"
    t.integer "property_id"
    t.integer "payment_id"
    t.integer "game_id"
    t.integer "highest_bid", default: 0
    t.boolean "in_progress", default: true
  end

  create_table "bidders", force: :cascade do |t|
    t.integer "auction_id"
    t.integer "user_id"
    t.integer "bid"
  end

  create_table "games", force: :cascade do |t|
  end

  create_table "payments", force: :cascade do |t|
    t.string "payee_account", limit: 5
    t.string "payer_account", limit: 5
    t.integer "amount"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "property_id"
    t.integer "auction_id"
    t.integer "game_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.integer "user_id"
    t.integer "auction_id"
    t.integer "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_payments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "payment_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.string "account_number", limit: 5
    t.integer "game_id"
    t.integer "balance", default: 15000000
    t.integer "bidder_id"
    t.integer "auction_id"
  end

end
