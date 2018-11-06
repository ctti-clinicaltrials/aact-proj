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

ActiveRecord::Schema.define(version: 2018_11_04_000122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.integer "project_id"
    t.string "file_name"
    t.string "content_type"
    t.binary "file_contents"
    t.boolean "is_image"
    t.text "description"
    t.string "original_file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_definitions", force: :cascade do |t|
    t.string "schema_name"
    t.string "table_name"
    t.string "column_name"
    t.string "category"
    t.string "label"
    t.string "data_type"
    t.string "source"
    t.text "description"
    t.string "nlm_link"
    t.json "enumerations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "datasets", force: :cascade do |t|
    t.integer "project_id"
    t.string "schema_name"
    t.string "table_name"
    t.string "dataset_type"
    t.string "file_name"
    t.string "content_type"
    t.string "name"
    t.binary "file_contents"
    t.string "url"
    t.date "made_available_on"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "status"
    t.date "start_date"
    t.date "completion_date"
    t.string "schema_name"
    t.boolean "data_available"
    t.string "migration_file_name"
    t.string "name"
    t.integer "year"
    t.string "brief_summary"
    t.string "investigators"
    t.string "organizations"
    t.string "url"
    t.text "description"
    t.text "protocol"
    t.text "issues"
    t.text "study_selection_criteria"
    t.string "submitter_name"
    t.string "contact_info"
    t.string "contact_url"
    t.string "email"
    t.binary "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completion_date"], name: "index_proj.projects_on_completion_date"
    t.index ["data_available"], name: "index_proj.projects_on_data_available"
    t.index ["investigators"], name: "index_proj.projects_on_investigators"
    t.index ["organizations"], name: "index_proj.projects_on_organizations"
    t.index ["start_date"], name: "index_proj.projects_on_start_date"
    t.index ["year"], name: "index_proj.projects_on_year"
  end

  create_table "publications", force: :cascade do |t|
    t.integer "project_id"
    t.string "pub_type"
    t.string "journal_name"
    t.string "title"
    t.string "url"
    t.string "citation"
    t.date "publication_date"
    t.text "abstract"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "y2010_mesh_terms", force: :cascade do |t|
    t.string "qualifier"
    t.string "tree_number"
    t.string "description"
    t.string "mesh_term"
    t.string "downcase_mesh_term"
    t.index ["description"], name: "index_proj.y2010_mesh_terms_on_description"
    t.index ["downcase_mesh_term"], name: "index_proj.y2010_mesh_terms_on_downcase_mesh_term"
    t.index ["mesh_term"], name: "index_proj.y2010_mesh_terms_on_mesh_term"
    t.index ["qualifier"], name: "index_proj.y2010_mesh_terms_on_qualifier"
  end

  create_table "y2016_mesh_headings", force: :cascade do |t|
    t.string "qualifier"
    t.string "heading"
    t.string "subcategory"
    t.index ["qualifier"], name: "index_proj.y2016_mesh_headings_on_qualifier"
  end

  create_table "y2016_mesh_terms", force: :cascade do |t|
    t.string "qualifier"
    t.string "tree_number"
    t.string "description"
    t.string "mesh_term"
    t.string "downcase_mesh_term"
    t.index ["description"], name: "index_proj.y2016_mesh_terms_on_description"
    t.index ["downcase_mesh_term"], name: "index_proj.y2016_mesh_terms_on_downcase_mesh_term"
    t.index ["mesh_term"], name: "index_proj.y2016_mesh_terms_on_mesh_term"
    t.index ["qualifier"], name: "index_proj.y2016_mesh_terms_on_qualifier"
  end

end
