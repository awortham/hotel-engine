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

ActiveRecord::Schema.define(version: 2019_12_11_210251) do

  create_table "movie_searches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "search_id"
    t.integer "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.boolean "adult", default: false, null: false
    t.string "poster_path"
    t.string "homepage"
    t.integer "api_id"
    t.integer "imdb_id"
    t.string "title"
    t.text "overview"
    t.integer "popularity"
    t.datetime "release_date"
    t.integer "revenue"
    t.string "status"
    t.string "tagline"
    t.integer "vote_average"
    t.integer "vote_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "criteria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
