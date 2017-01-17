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

ActiveRecord::Schema.define(version: 20170117163454) do

  create_table "champions_masteries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "summonerId"
    t.string   "region"
    t.json     "masteries"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "masteries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "summonerId"
    t.json     "pages"
    t.string   "region"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "runes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "summonerId"
    t.json     "pages"
    t.string   "region"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stats_summaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "summonerId"
    t.string   "region"
    t.string   "season"
    t.json     "playerStatSummaries"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "summoners", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "summonerId"
    t.integer  "profileIconId"
    t.integer  "summonerLevel"
    t.string   "region"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
