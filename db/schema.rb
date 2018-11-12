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

ActiveRecord::Schema.define(version: 2018_11_08_000122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analyzed_studies", force: :cascade do |t|
    t.string "nct_id"
    t.string "brief_title"
    t.string "keywords"
    t.string "conditions"
    t.string "mesh_terms"
    t.index ["agency_class"], name: "index_proj_anderson.analyzed_studies_on_agency_class"
    t.index ["funding"], name: "index_proj_anderson.analyzed_studies_on_funding"
    t.index ["masking"], name: "index_proj_anderson.analyzed_studies_on_masking"
    t.index ["overall_status"], name: "index_proj_anderson.analyzed_studies_on_overall_status"
    t.index ["phase"], name: "index_proj_anderson.analyzed_studies_on_phase"
    t.index ["primary_purpose"], name: "index_proj_anderson.analyzed_studies_on_primary_purpose"
  end

  create_table "analyzed_studies", force: :cascade do |t|
    t.string "nct_id"
    t.string "brief_title"
    t.string "keywords"
    t.string "conditions"
    t.string "mesh_terms"
    t.index ["agency_class"], name: "index_proj_anderson.analyzed_studies_on_agency_class"
    t.index ["funding"], name: "index_proj_anderson.analyzed_studies_on_funding"
    t.index ["masking"], name: "index_proj_anderson.analyzed_studies_on_masking"
    t.index ["overall_status"], name: "index_proj_anderson.analyzed_studies_on_overall_status"
    t.index ["phase"], name: "index_proj_anderson.analyzed_studies_on_phase"
    t.index ["primary_purpose"], name: "index_proj_anderson.analyzed_studies_on_primary_purpose"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "lowercase_name"
  end

  create_table "synonyms", force: :cascade do |t|
    t.string "name"
    t.string "preferred_name"
    t.string "lowercase_name"
    t.string "lowercase_preferred_name"
  end

  create_table "tagged_terms", force: :cascade do |t|
    t.string "term"
    t.string "term_type"
  end

  create_table "tagged_terms", force: :cascade do |t|
    t.string "term"
    t.string "term_type"
  end

end
