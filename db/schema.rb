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

ActiveRecord::Schema.define(version: 20170426193030) do

  create_table "champions_masteries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "summonerId", null: false
    t.json     "masteries"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games_recents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "summonerId", null: false
    t.string   "region"
    t.json     "games"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "league_entries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "summonerId", null: false
    t.string   "region"
    t.json     "entries"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "masteries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "summonerId", null: false
    t.json     "pages"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "queueType"
    t.integer  "mapId"
    t.bigint   "gameCreation"
    t.string   "gameMode"
    t.integer  "gameDuration"
    t.string   "gameType"
    t.json     "teams"
    t.json     "participants"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "seasonId"
    t.integer  "queueId"
    t.string   "gameVersion"
    t.string   "platformId"
  end

  create_table "pro_builds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.bigint   "gameCreation"
    t.integer  "spell1Id"
    t.integer  "spell2Id"
    t.integer  "championId"
    t.string   "highestAchievedSeasonTier"
    t.json     "masteries"
    t.json     "runes"
    t.json     "stats"
    t.json     "itemsOrder"
    t.json     "skillsOrder"
    t.integer  "pro_summoner_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "gameId",                    limit: 50
    t.integer  "seasonId"
    t.integer  "queueId"
    t.string   "gameVersion"
    t.string   "platformId"
    t.string   "gameMode"
    t.integer  "mapId"
    t.string   "gameType"
    t.bigint   "gameDuration"
    t.index ["pro_summoner_id"], name: "index_pro_builds_on_pro_summoner_id", using: :btree
  end

  create_table "pro_players", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "name"
    t.string   "imageUrl"
    t.string   "realName"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pro_summoners", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "summonerId",    null: false
    t.bigint   "lastCheck"
    t.integer  "pro_player_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.bigint   "accountId"
    t.index ["pro_player_id"], name: "index_pro_summoners_on_pro_player_id", using: :btree
  end

  create_table "runes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "summonerId", null: false
    t.json     "pages"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stats_rankeds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "summonerId", null: false
    t.json     "champions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stats_summaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "summonerId",          null: false
    t.string   "season"
    t.json     "playerStatSummaries"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "summoners", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "name"
    t.integer  "profileIconId"
    t.integer  "summonerLevel"
    t.string   "region"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.bigint   "accountId"
  end

end
