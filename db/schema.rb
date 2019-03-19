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

ActiveRecord::Schema.define(version: 2019_03_07_000122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analyzed_studies", force: :cascade do |t|
    t.string "nct_id"
    t.string "brief_title"
    t.string "lead_sponsor"
  end

  create_table "cardiovascular_studies", force: :cascade do |t|
    t.string "nct_id"
    t.string "brief_title"
    t.string "lead_sponsor"
  end

  create_table "mental_health_studies", force: :cascade do |t|
    t.string "nct_id"
    t.string "brief_title"
    t.string "lead_sponsor"
  end

  create_table "oncology_studies", force: :cascade do |t|
    t.string "nct_id"
    t.string "brief_title"
    t.string "lead_sponsor"
  end

  create_table "tagged_terms", force: :cascade do |t|
    t.string "tag"
    t.string "term"
    t.string "term_type"
  end

  create_table "tagged_terms", force: :cascade do |t|
    t.string "tag"
    t.string "term"
    t.string "term_type"
  end

  create_table "tagged_terms", force: :cascade do |t|
    t.string "tag"
    t.string "term"
    t.string "term_type"
  end

  create_table "y2010_mesh_terms", force: :cascade do |t|
    t.string "qualifier"
    t.string "tree_number"
    t.string "description"
    t.string "mesh_term"
    t.string "downcase_mesh_term"
    t.index ["description"], name: "index_mesh_archive.y2010_mesh_terms_on_description"
    t.index ["downcase_mesh_term"], name: "index_mesh_archive.y2010_mesh_terms_on_downcase_mesh_term"
    t.index ["mesh_term"], name: "index_mesh_archive.y2010_mesh_terms_on_mesh_term"
    t.index ["qualifier"], name: "index_mesh_archive.y2010_mesh_terms_on_qualifier"
  end

  create_table "y2016_mesh_headings", force: :cascade do |t|
    t.string "qualifier"
    t.string "heading"
    t.string "subcategory"
    t.index ["qualifier"], name: "index_mesh_archive.y2016_mesh_headings_on_qualifier"
  end

  create_table "y2016_mesh_terms", force: :cascade do |t|
    t.string "qualifier"
    t.string "tree_number"
    t.string "description"
    t.string "mesh_term"
    t.string "downcase_mesh_term"
    t.index ["description"], name: "index_mesh_archive.y2016_mesh_terms_on_description"
    t.index ["downcase_mesh_term"], name: "index_mesh_archive.y2016_mesh_terms_on_downcase_mesh_term"
    t.index ["mesh_term"], name: "index_mesh_archive.y2016_mesh_terms_on_mesh_term"
    t.index ["qualifier"], name: "index_mesh_archive.y2016_mesh_terms_on_qualifier"
  end

end
