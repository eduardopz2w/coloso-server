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

ActiveRecord::Schema.define(version: 20170117201833) do

  create_table "champions_masteries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "summonerUrid", null: false
    t.json     "masteries"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "games_recents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "summonerUrid", null: false
    t.string   "region"
    t.json     "games"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "league_entries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "summonerUrid", null: false
    t.string   "region"
    t.json     "entries"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "masteries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "summonerUrid", null: false
    t.json     "pages"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "pro_builds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "matchId"
    t.bigint   "matchCreation"
    t.integer  "spell1Id"
    t.integer  "spell2Id"
    t.integer  "championId"
    t.string   "highestAchievedSeasonTier"
    t.string   "region"
    t.json     "masteries"
    t.json     "runes"
    t.json     "stats"
    t.json     "itemsOrder"
    t.json     "skillsOrder"
    t.integer  "pro_summoner_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["pro_summoner_id"], name: "index_pro_builds_on_pro_summoner_id", using: :btree
  end

  create_table "pro_players", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "imageUrl"
    t.string   "realName"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pro_summoners", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "summonerUrid",  null: false
    t.bigint   "lastCheck"
    t.integer  "pro_player_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["pro_player_id"], name: "index_pro_summoners_on_pro_player_id", using: :btree
  end

  create_table "runes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "summonerUrid", null: false
    t.json     "pages"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "stats_summaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "summonerUrid",        null: false
    t.string   "season"
    t.json     "playerStatSummaries"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "summoners", primary_key: "urid", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "profileIconId"
    t.integer  "summonerLevel"
    t.string   "region"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
