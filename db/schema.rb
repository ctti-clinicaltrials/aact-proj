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

ActiveRecord::Schema.define(version: 2018_07_19_000122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analyzed_free_text_terms", force: :cascade do |t|
    t.string "identifier"
    t.string "term"
    t.string "downcase_term"
    t.index ["downcase_term"], name: "index_project1.analyzed_free_text_terms_on_downcase_term"
    t.index ["term"], name: "index_project1.analyzed_free_text_terms_on_term"
  end

  create_table "analyzed_mesh_terms", force: :cascade do |t|
    t.string "qualifier"
    t.string "identifier"
    t.string "term"
    t.string "downcase_term"
    t.string "description"
    t.index ["description"], name: "index_project1.analyzed_mesh_terms_on_description"
    t.index ["downcase_term"], name: "index_project1.analyzed_mesh_terms_on_downcase_term"
    t.index ["qualifier"], name: "index_project1.analyzed_mesh_terms_on_qualifier"
    t.index ["term"], name: "index_project1.analyzed_mesh_terms_on_term"
  end

  create_table "attachments", force: :cascade do |t|
    t.integer "use_case_id"
    t.string "file_name"
    t.string "content_type"
    t.binary "file_contents"
    t.boolean "is_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categorized_terms", force: :cascade do |t|
    t.integer "project_id"
    t.string "identifier"
    t.string "category"
    t.string "term"
    t.string "year"
    t.string "term_type"
    t.index ["category"], name: "index_project1.categorized_terms_on_category"
    t.index ["identifier"], name: "index_project1.categorized_terms_on_identifier"
    t.index ["term_type"], name: "index_project1.categorized_terms_on_term_type"
  end

  create_table "clinical_categories", force: :cascade do |t|
    t.string "name"
    t.string "downcase_name"
  end

  create_table "datasets", force: :cascade do |t|
    t.integer "use_case_id"
    t.string "dataset_type"
    t.string "name"
    t.string "url"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publications", force: :cascade do |t|
    t.integer "use_case_id"
    t.string "name"
    t.string "url"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "use_cases", force: :cascade do |t|
    t.string "status"
    t.date "start_date"
    t.date "completion_date"
    t.string "schema_name"
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
    t.string "email"
    t.binary "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completion_date"], name: "index_projects.use_cases_on_completion_date"
    t.index ["investigators"], name: "index_projects.use_cases_on_investigators"
    t.index ["organizations"], name: "index_projects.use_cases_on_organizations"
    t.index ["start_date"], name: "index_projects.use_cases_on_start_date"
    t.index ["year"], name: "index_projects.use_cases_on_year"
  end

  create_table "y2010_mesh_terms", force: :cascade do |t|
    t.string "qualifier"
    t.string "tree_number"
    t.string "description"
    t.string "mesh_term"
    t.string "downcase_mesh_term"
    t.index ["description"], name: "index_projects.y2010_mesh_terms_on_description"
    t.index ["downcase_mesh_term"], name: "index_projects.y2010_mesh_terms_on_downcase_mesh_term"
    t.index ["mesh_term"], name: "index_projects.y2010_mesh_terms_on_mesh_term"
    t.index ["qualifier"], name: "index_projects.y2010_mesh_terms_on_qualifier"
  end

  create_table "y2016_mesh_headings", force: :cascade do |t|
    t.string "qualifier"
    t.string "heading"
    t.string "subcategory"
    t.index ["qualifier"], name: "index_projects.y2016_mesh_headings_on_qualifier"
  end

  create_table "y2016_mesh_terms", force: :cascade do |t|
    t.string "qualifier"
    t.string "tree_number"
    t.string "description"
    t.string "mesh_term"
    t.string "downcase_mesh_term"
    t.index ["description"], name: "index_projects.y2016_mesh_terms_on_description"
    t.index ["downcase_mesh_term"], name: "index_projects.y2016_mesh_terms_on_downcase_mesh_term"
    t.index ["mesh_term"], name: "index_projects.y2016_mesh_terms_on_mesh_term"
    t.index ["qualifier"], name: "index_projects.y2016_mesh_terms_on_qualifier"
  end

end
