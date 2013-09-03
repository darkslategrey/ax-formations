# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 0) do

  create_table "contrat", primary_key: "ID_nat", force: true do |t|
    t.text "contrat", limit: 255, null: false
  end

  create_table "experience", primary_key: "ID_exp", force: true do |t|
    t.text "experience", limit: 255, null: false
  end

  create_table "experience2", primary_key: "ID_exp2", force: true do |t|
    t.text "experience2", limit: 255, null: false
  end

  create_table "geo", primary_key: "ID_Geo", force: true do |t|
    t.text "Geo",  limit: 255, null: false
    t.text "code", limit: 255, null: false
  end

  create_table "geo_zipcode", primary_key: "INSEE", force: true do |t|
    t.string "ZIP",    limit: 7
    t.text   "VILLE"
    t.string "CODREG", limit: 7
    t.text   "REGION"
  end

  create_table "offer", primary_key: "ID", force: true do |t|
    t.boolean  "VIS",                        default: false
    t.boolean  "URG",                        default: false
    t.integer  "ID_TYPDET", limit: 1,        default: 1
    t.datetime "DATE"
    t.datetime "UPDATE"
    t.datetime "KELDATE"
    t.integer  "TYPE",      limit: 2,        default: 0
    t.string   "JOBTYPE",   limit: 4
    t.integer  "URGTYPE1",  limit: 1,        default: 0
    t.integer  "URGTYPE2",  limit: 1,        default: 0
    t.text     "CONTRACT",  limit: 255
    t.text     "TIT",       limit: 255,                      null: false
    t.text     "ENT",       limit: 255,                      null: false
    t.text     "CITY",      limit: 255,                      null: false
    t.text     "LOC",       limit: 255,                      null: false
    t.text     "ZIP",       limit: 255,                      null: false
    t.text     "REGLOC",    limit: 255,                      null: false
    t.integer  "NAT",       limit: 1,        default: 0
    t.text     "DUR",       limit: 255
    t.integer  "IDTC",      limit: 1,        default: 0
    t.integer  "IDTP",      limit: 1,        default: 0
    t.text     "ADV",       limit: 255
    t.text     "BEG",       limit: 255
    t.text     "PRICE",     limit: 255
    t.boolean  "EXP",                        default: false
    t.integer  "EXP2",      limit: 1
    t.text     "ART"
    t.text     "REF",       limit: 255
    t.text     "HOW",       limit: 16777215
    t.boolean  "HOWTYPE",                    default: false
    t.text     "CONT",      limit: 255
    t.text     "ADR",       limit: 16777215
    t.text     "TEL",       limit: 255
    t.text     "FAX",       limit: 255
    t.text     "MAIL",      limit: 255
    t.text     "WEB",       limit: 255
    t.text     "LNK",       limit: 255
    t.text     "LOG"
    t.integer  "GLOB",      limit: 1,        default: 0,     null: false
    t.integer  "CONTI",     limit: 1,        default: 4,     null: false
    t.text     "LANG",      limit: 255
    t.integer  "VIEW",      limit: 3,        default: 0
    t.integer  "COUNT",     limit: 3,        default: 0
  end

  add_index "offer", ["TIT", "ENT", "ART"], name: "ART", type: :fulltext

  create_table "regeo", primary_key: "ID_regeo", force: true do |t|
    t.text "regeo",  limit: 255, null: false
    t.text "recode", limit: 255, null: false
  end

  create_table "secteur", primary_key: "ID_sec", force: true do |t|
    t.text "secteur", limit: 255, null: false
  end

  create_table "sessions", primary_key: "ID", force: true do |t|
    t.text     "LOGIN",       limit: 255,                 null: false
    t.text     "PASSWD",      limit: 255,                 null: false
    t.integer  "PRIV",        limit: 1,   default: 0
    t.integer  "PRODUCT",     limit: 1,   default: 0
    t.integer  "RIGHT",       limit: 1,   default: 1,     null: false
    t.integer  "RIGHT2",      limit: 1,   default: 1,     null: false
    t.integer  "MODE",        limit: 1,   default: 0,     null: false
    t.integer  "MODE2",       limit: 1,   default: 0,     null: false
    t.integer  "CREDITS",     limit: 2,   default: 0
    t.integer  "CREDITS2",    limit: 2,   default: 0
    t.text     "GR",          limit: 255
    t.integer  "NEWGR",       limit: 1,   default: 2,     null: false
    t.text     "NOM",         limit: 255
    t.text     "PRENOM",      limit: 255
    t.integer  "JJ",          limit: 1,   default: 0
    t.integer  "MM",          limit: 1,   default: 0
    t.integer  "AAAA",        limit: 2,   default: 0
    t.datetime "DATECREA"
    t.datetime "DATEUPDATE"
    t.datetime "DATEEND",                                 null: false
    t.datetime "DATEEND2",                                null: false
    t.text     "GEO",         limit: 255
    t.integer  "ZONE",        limit: 1,   default: 4,     null: false
    t.integer  "RANGE",       limit: 1,   default: 1,     null: false
    t.text     "LANGUAGE",    limit: 255
    t.integer  "LANG",        limit: 1,   default: 0,     null: false
    t.text     "SOCIETE",     limit: 255,                 null: false
    t.text     "CONTRAT",     limit: 255,                 null: false
    t.text     "WEB",         limit: 255
    t.text     "LOGO",        limit: 255
    t.boolean  "LOGOSPONSOR",             default: false
    t.string   "LOGOTXT",     limit: 200
    t.text     "TEL",         limit: 255
    t.text     "MAIL",        limit: 255
    t.text     "FUNCT",       limit: 255
    t.text     "FAX",         limit: 255
    t.text     "ADRESSE"
    t.text     "RMAIL",       limit: 255
    t.text     "RLINK",       limit: 255
    t.integer  "WHO",         limit: 1,   default: 2,     null: false
    t.text     "OBS1"
    t.text     "OBS2"
    t.integer  "CVIEW",       limit: 3,   default: 0
    t.integer  "CVIEWCV",     limit: 3,   default: 0
    t.integer  "CCONEX",      limit: 3,   default: 0
    t.text     "CCODE",       limit: 255,                 null: false
    t.datetime "CLAST"
    t.datetime "CBEFORE"
    t.integer  "TYPEREC",     limit: 1,                   null: false
  end

end
