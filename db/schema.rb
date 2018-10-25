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

ActiveRecord::Schema.define(version: 2018_09_18_000122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analyzed_studies", force: :cascade do |t|
    t.string "nct_id"
    t.string "url"
    t.string "brief_title"
    t.string "start_month"
    t.integer "start_year"
    t.string "overall_status"
    t.string "p_completion_month"
    t.integer "p_completion_year"
    t.string "completion_month"
    t.integer "completion_year"
    t.string "verification_month"
    t.integer "verification_year"
    t.integer "p_comp_mn"
    t.integer "p_comp_yr"
    t.integer "received_year"
    t.integer "mntopcom"
    t.integer "enrollment"
    t.integer "number_of_arms"
    t.string "allocation"
    t.string "masking"
    t.string "phase"
    t.string "primary_purpose"
    t.string "sponsor_name"
    t.string "agency_class"
    t.string "collaborator_names"
    t.string "funding"
    t.string "responsible_party_type"
    t.string "responsible_party_organization"
    t.string "us_coderc"
    t.string "oversight"
    t.string "behavioral"
    t.string "biological"
    t.string "device"
    t.string "dietsup"
    t.string "drug"
    t.string "genetic"
    t.string "procedure"
    t.string "radiation"
    t.string "otherint"
    t.string "intervg1"
    t.string "results"
    t.string "resultsreceived_month"
    t.string "resultsreceived_year"
    t.date "firstreceived_results_dt"
    t.integer "t2result"
    t.integer "t2result_imp"
    t.integer "t2resmod"
    t.string "results12"
    t.string "delayed"
    t.date "dr_received_dt"
    t.boolean "mn2delay"
    t.boolean "delayed12"
    t.index ["agency_class"], name: "index_proj_anderson.analyzed_studies_on_agency_class"
    t.index ["funding"], name: "index_proj_anderson.analyzed_studies_on_funding"
    t.index ["masking"], name: "index_proj_anderson.analyzed_studies_on_masking"
    t.index ["overall_status"], name: "index_proj_anderson.analyzed_studies_on_overall_status"
    t.index ["phase"], name: "index_proj_anderson.analyzed_studies_on_phase"
    t.index ["primary_purpose"], name: "index_proj_anderson.analyzed_studies_on_primary_purpose"
  end

  create_table "attachments", force: :cascade do |t|
    t.integer "project_id"
    t.string "file_name"
    t.string "content_type"
    t.binary "file_contents"
    t.boolean "is_image"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "baseline_counts", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "result_group_id"
    t.string "ctgov_group_code"
    t.string "units"
    t.string "scope"
    t.integer "count"
    t.index ["nct_id"], name: "index_baseline_counts_on_nct_id"
  end

  create_table "baseline_measurements", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "result_group_id"
    t.string "ctgov_group_code"
    t.string "classification"
    t.string "category"
    t.string "title"
    t.text "description"
    t.string "units"
    t.string "param_type"
    t.string "param_value"
    t.decimal "param_value_num"
    t.string "dispersion_type"
    t.string "dispersion_value"
    t.decimal "dispersion_value_num"
    t.decimal "dispersion_lower_limit"
    t.decimal "dispersion_upper_limit"
    t.string "explanation_of_na"
    t.index ["category"], name: "index_baseline_measurements_on_category"
    t.index ["classification"], name: "index_baseline_measurements_on_classification"
    t.index ["dispersion_type"], name: "index_baseline_measurements_on_dispersion_type"
    t.index ["nct_id"], name: "index_baseline_measurements_on_nct_id"
    t.index ["param_type"], name: "index_baseline_measurements_on_param_type"
  end

  create_table "brief_summaries", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.text "description"
    t.index ["nct_id"], name: "index_brief_summaries_on_nct_id"
  end

  create_table "browse_conditions", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "mesh_term"
    t.string "downcase_mesh_term"
    t.index ["downcase_mesh_term"], name: "index_browse_conditions_on_downcase_mesh_term"
    t.index ["mesh_term"], name: "index_browse_conditions_on_mesh_term"
    t.index ["nct_id"], name: "index_browse_conditions_on_nct_id"
  end

  create_table "browse_interventions", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "mesh_term"
    t.string "downcase_mesh_term"
    t.index ["downcase_mesh_term"], name: "index_browse_interventions_on_downcase_mesh_term"
    t.index ["mesh_term"], name: "index_browse_interventions_on_mesh_term"
    t.index ["nct_id"], name: "index_browse_interventions_on_nct_id"
  end

  create_table "calculated_values", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "number_of_facilities"
    t.integer "number_of_nsae_subjects"
    t.integer "number_of_sae_subjects"
    t.integer "registered_in_calendar_year"
    t.date "nlm_download_date"
    t.integer "actual_duration"
    t.boolean "were_results_reported", default: false
    t.integer "months_to_report_results"
    t.boolean "has_us_facility"
    t.boolean "has_single_facility", default: false
    t.integer "minimum_age_num"
    t.integer "maximum_age_num"
    t.string "minimum_age_unit"
    t.string "maximum_age_unit"
    t.index ["actual_duration"], name: "index_calculated_values_on_actual_duration"
    t.index ["months_to_report_results"], name: "index_calculated_values_on_months_to_report_results"
    t.index ["nct_id"], name: "index_calculated_values_on_nct_id"
    t.index ["number_of_facilities"], name: "index_calculated_values_on_number_of_facilities"
  end

  create_table "central_contacts", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "contact_type"
    t.string "name"
    t.string "phone"
    t.string "email"
    t.index ["contact_type"], name: "index_central_contacts_on_contact_type"
    t.index ["nct_id"], name: "index_central_contacts_on_nct_id"
  end

  create_table "conditions", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "name"
    t.string "downcase_name"
    t.index ["downcase_name"], name: "index_conditions_on_downcase_name"
    t.index ["name"], name: "index_conditions_on_name"
    t.index ["nct_id"], name: "index_conditions_on_nct_id"
  end

  create_table "countries", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "name"
    t.boolean "removed"
    t.index ["nct_id"], name: "index_countries_on_nct_id"
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

  create_table "design_group_interventions", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "design_group_id"
    t.integer "intervention_id"
    t.index ["nct_id"], name: "index_design_group_interventions_on_nct_id"
  end

  create_table "design_groups", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "group_type"
    t.string "title"
    t.text "description"
    t.index ["group_type"], name: "index_design_groups_on_group_type"
    t.index ["nct_id"], name: "index_design_groups_on_nct_id"
  end

  create_table "design_outcomes", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "outcome_type"
    t.text "measure"
    t.text "time_frame"
    t.string "population"
    t.text "description"
    t.index ["nct_id"], name: "index_design_outcomes_on_nct_id"
    t.index ["outcome_type"], name: "index_design_outcomes_on_outcome_type"
  end

  create_table "designs", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "allocation"
    t.string "intervention_model"
    t.string "observational_model"
    t.string "primary_purpose"
    t.string "time_perspective"
    t.string "masking"
    t.text "masking_description"
    t.text "intervention_model_description"
    t.boolean "subject_masked"
    t.boolean "caregiver_masked"
    t.boolean "investigator_masked"
    t.boolean "outcomes_assessor_masked"
    t.index ["caregiver_masked"], name: "index_designs_on_caregiver_masked"
    t.index ["investigator_masked"], name: "index_designs_on_investigator_masked"
    t.index ["masking"], name: "index_designs_on_masking"
    t.index ["nct_id"], name: "index_designs_on_nct_id"
    t.index ["outcomes_assessor_masked"], name: "index_designs_on_outcomes_assessor_masked"
    t.index ["subject_masked"], name: "index_designs_on_subject_masked"
  end

  create_table "detailed_descriptions", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.text "description"
    t.index ["nct_id"], name: "index_detailed_descriptions_on_nct_id"
  end

  create_table "documents", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "document_id"
    t.string "document_type"
    t.string "url"
    t.text "comment"
    t.index ["document_id"], name: "index_documents_on_document_id"
    t.index ["document_type"], name: "index_documents_on_document_type"
    t.index ["nct_id"], name: "index_documents_on_nct_id"
  end

  create_table "drop_withdrawals", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "result_group_id"
    t.string "ctgov_group_code"
    t.string "period"
    t.string "reason"
    t.integer "count"
    t.index ["nct_id"], name: "index_drop_withdrawals_on_nct_id"
    t.index ["period"], name: "index_drop_withdrawals_on_period"
  end

  create_table "eligibilities", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "sampling_method"
    t.string "gender"
    t.string "minimum_age"
    t.string "maximum_age"
    t.string "healthy_volunteers"
    t.text "population"
    t.text "criteria"
    t.text "gender_description"
    t.boolean "gender_based"
    t.index ["gender"], name: "index_eligibilities_on_gender"
    t.index ["healthy_volunteers"], name: "index_eligibilities_on_healthy_volunteers"
    t.index ["maximum_age"], name: "index_eligibilities_on_maximum_age"
    t.index ["minimum_age"], name: "index_eligibilities_on_minimum_age"
    t.index ["nct_id"], name: "index_eligibilities_on_nct_id"
  end

  create_table "facilities", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "status"
    t.string "name"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.index ["city"], name: "index_facilities_on_city"
    t.index ["country"], name: "index_facilities_on_country"
    t.index ["name"], name: "index_facilities_on_name"
    t.index ["nct_id"], name: "index_facilities_on_nct_id"
    t.index ["state"], name: "index_facilities_on_state"
    t.index ["status"], name: "index_facilities_on_status"
  end

  create_table "facility_contacts", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "facility_id"
    t.string "contact_type"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.index ["contact_type"], name: "index_facility_contacts_on_contact_type"
    t.index ["nct_id"], name: "index_facility_contacts_on_nct_id"
  end

  create_table "facility_investigators", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "facility_id"
    t.string "role"
    t.string "name"
    t.index ["nct_id"], name: "index_facility_investigators_on_nct_id"
  end

  create_table "id_information", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "id_type"
    t.string "id_value"
    t.index ["id_type"], name: "index_id_information_on_id_type"
    t.index ["nct_id"], name: "index_id_information_on_nct_id"
  end

  create_table "intervention_other_names", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "intervention_id"
    t.string "name"
    t.index ["nct_id"], name: "index_intervention_other_names_on_nct_id"
  end

  create_table "interventions", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "intervention_type"
    t.string "name"
    t.text "description"
    t.index ["intervention_type"], name: "index_interventions_on_intervention_type"
    t.index ["nct_id"], name: "index_interventions_on_nct_id"
  end

  create_table "ipd_information_types", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "name"
    t.index ["nct_id"], name: "index_ipd_information_types_on_nct_id"
  end

  create_table "keywords", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "name"
    t.string "downcase_name"
    t.index ["downcase_name"], name: "index_keywords_on_downcase_name"
    t.index ["name"], name: "index_keywords_on_name"
    t.index ["nct_id"], name: "index_keywords_on_nct_id"
  end

  create_table "links", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "url"
    t.text "description"
    t.index ["nct_id"], name: "index_links_on_nct_id"
  end

  create_table "mesh_headings", id: :serial, force: :cascade do |t|
    t.string "qualifier"
    t.string "heading"
    t.string "subcategory"
    t.index ["qualifier"], name: "index_mesh_headings_on_qualifier"
  end

  create_table "mesh_terms", id: :serial, force: :cascade do |t|
    t.string "qualifier"
    t.string "tree_number"
    t.string "description"
    t.string "mesh_term"
    t.string "downcase_mesh_term"
    t.index ["description"], name: "index_mesh_terms_on_description"
    t.index ["downcase_mesh_term"], name: "index_mesh_terms_on_downcase_mesh_term"
    t.index ["mesh_term"], name: "index_mesh_terms_on_mesh_term"
    t.index ["qualifier"], name: "index_mesh_terms_on_qualifier"
  end

  create_table "milestones", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "result_group_id"
    t.string "ctgov_group_code"
    t.string "title"
    t.string "period"
    t.text "description"
    t.integer "count"
    t.index ["nct_id"], name: "index_milestones_on_nct_id"
    t.index ["period"], name: "index_milestones_on_period"
  end

  create_table "outcome_analyses", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "outcome_id"
    t.string "non_inferiority_type"
    t.text "non_inferiority_description"
    t.string "param_type"
    t.decimal "param_value"
    t.string "dispersion_type"
    t.decimal "dispersion_value"
    t.string "p_value_modifier"
    t.float "p_value"
    t.string "ci_n_sides"
    t.decimal "ci_percent"
    t.decimal "ci_lower_limit"
    t.decimal "ci_upper_limit"
    t.string "ci_upper_limit_na_comment"
    t.string "p_value_description"
    t.string "method"
    t.text "method_description"
    t.text "estimate_description"
    t.text "groups_description"
    t.text "other_analysis_description"
    t.index ["dispersion_type"], name: "index_outcome_analyses_on_dispersion_type"
    t.index ["nct_id"], name: "index_outcome_analyses_on_nct_id"
    t.index ["param_type"], name: "index_outcome_analyses_on_param_type"
  end

  create_table "outcome_analysis_groups", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "outcome_analysis_id"
    t.integer "result_group_id"
    t.string "ctgov_group_code"
    t.index ["nct_id"], name: "index_outcome_analysis_groups_on_nct_id"
  end

  create_table "outcome_counts", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "outcome_id"
    t.integer "result_group_id"
    t.string "ctgov_group_code"
    t.string "scope"
    t.string "units"
    t.integer "count"
    t.index ["nct_id"], name: "index_outcome_counts_on_nct_id"
  end

  create_table "outcome_measurements", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "outcome_id"
    t.integer "result_group_id"
    t.string "ctgov_group_code"
    t.string "classification"
    t.string "category"
    t.string "title"
    t.text "description"
    t.string "units"
    t.string "param_type"
    t.string "param_value"
    t.decimal "param_value_num"
    t.string "dispersion_type"
    t.string "dispersion_value"
    t.decimal "dispersion_value_num"
    t.decimal "dispersion_lower_limit"
    t.decimal "dispersion_upper_limit"
    t.text "explanation_of_na"
    t.index ["category"], name: "index_outcome_measurements_on_category"
    t.index ["classification"], name: "index_outcome_measurements_on_classification"
    t.index ["dispersion_type"], name: "index_outcome_measurements_on_dispersion_type"
    t.index ["nct_id"], name: "index_outcome_measurements_on_nct_id"
  end

  create_table "outcomes", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "outcome_type"
    t.text "title"
    t.text "description"
    t.text "time_frame"
    t.text "population"
    t.date "anticipated_posting_date"
    t.string "anticipated_posting_month_year"
    t.string "units"
    t.string "units_analyzed"
    t.string "dispersion_type"
    t.string "param_type"
    t.index ["dispersion_type"], name: "index_outcomes_on_dispersion_type"
    t.index ["nct_id"], name: "index_outcomes_on_nct_id"
    t.index ["param_type"], name: "index_outcomes_on_param_type"
  end

  create_table "overall_officials", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "role"
    t.string "name"
    t.string "affiliation"
    t.index ["affiliation"], name: "index_overall_officials_on_affiliation"
    t.index ["nct_id"], name: "index_overall_officials_on_nct_id"
  end

  create_table "participant_flows", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.text "recruitment_details"
    t.text "pre_assignment_details"
    t.index ["nct_id"], name: "index_participant_flows_on_nct_id"
  end

  create_table "pending_results", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "event"
    t.string "event_date_description"
    t.date "event_date"
    t.index ["nct_id"], name: "index_pending_results_on_nct_id"
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

  create_table "reported_events", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.integer "result_group_id"
    t.string "ctgov_group_code"
    t.text "time_frame"
    t.string "event_type"
    t.string "default_vocab"
    t.string "default_assessment"
    t.integer "subjects_affected"
    t.integer "subjects_at_risk"
    t.text "description"
    t.integer "event_count"
    t.string "organ_system"
    t.string "adverse_event_term"
    t.integer "frequency_threshold"
    t.string "vocab"
    t.string "assessment"
    t.index ["event_type"], name: "index_reported_events_on_event_type"
    t.index ["nct_id"], name: "index_reported_events_on_nct_id"
    t.index ["subjects_affected"], name: "index_reported_events_on_subjects_affected"
  end

  create_table "responsible_parties", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "responsible_party_type"
    t.string "name"
    t.string "title"
    t.string "organization"
    t.text "affiliation"
    t.index ["nct_id"], name: "index_responsible_parties_on_nct_id"
    t.index ["organization"], name: "index_responsible_parties_on_organization"
    t.index ["responsible_party_type"], name: "index_responsible_parties_on_responsible_party_type"
  end

  create_table "result_agreements", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "pi_employee"
    t.text "agreement"
    t.index ["nct_id"], name: "index_result_agreements_on_nct_id"
  end

  create_table "result_contacts", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "organization"
    t.string "name"
    t.string "phone"
    t.string "email"
    t.index ["nct_id"], name: "index_result_contacts_on_nct_id"
    t.index ["organization"], name: "index_result_contacts_on_organization"
  end

  create_table "result_groups", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "ctgov_group_code"
    t.string "result_type"
    t.string "title"
    t.text "description"
    t.index ["nct_id"], name: "index_result_groups_on_nct_id"
    t.index ["result_type"], name: "index_result_groups_on_result_type"
  end

  create_table "sponsors", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "agency_class"
    t.string "lead_or_collaborator"
    t.string "name"
    t.index ["agency_class"], name: "index_sponsors_on_agency_class"
    t.index ["name"], name: "index_sponsors_on_name"
    t.index ["nct_id"], name: "index_sponsors_on_nct_id"
  end

  create_table "studies", id: false, force: :cascade do |t|
    t.string "nct_id"
    t.string "nlm_download_date_description"
    t.date "study_first_submitted_date"
    t.date "results_first_submitted_date"
    t.date "disposition_first_submitted_date"
    t.date "last_update_submitted_date"
    t.date "study_first_submitted_qc_date"
    t.date "study_first_posted_date"
    t.string "study_first_posted_date_type"
    t.date "results_first_submitted_qc_date"
    t.date "results_first_posted_date"
    t.string "results_first_posted_date_type"
    t.date "disposition_first_submitted_qc_date"
    t.date "disposition_first_posted_date"
    t.string "disposition_first_posted_date_type"
    t.date "last_update_submitted_qc_date"
    t.date "last_update_posted_date"
    t.string "last_update_posted_date_type"
    t.string "start_month_year"
    t.string "start_date_type"
    t.date "start_date"
    t.string "verification_month_year"
    t.date "verification_date"
    t.string "completion_month_year"
    t.string "completion_date_type"
    t.date "completion_date"
    t.string "primary_completion_month_year"
    t.string "primary_completion_date_type"
    t.date "primary_completion_date"
    t.string "target_duration"
    t.string "study_type"
    t.string "acronym"
    t.text "baseline_population"
    t.text "brief_title"
    t.text "official_title"
    t.string "overall_status"
    t.string "last_known_status"
    t.string "phase"
    t.integer "enrollment"
    t.string "enrollment_type"
    t.string "source"
    t.string "limitations_and_caveats"
    t.integer "number_of_arms"
    t.integer "number_of_groups"
    t.string "why_stopped"
    t.boolean "has_expanded_access"
    t.boolean "expanded_access_type_individual"
    t.boolean "expanded_access_type_intermediate"
    t.boolean "expanded_access_type_treatment"
    t.boolean "has_dmc"
    t.boolean "is_fda_regulated_drug"
    t.boolean "is_fda_regulated_device"
    t.boolean "is_unapproved_device"
    t.boolean "is_ppsd"
    t.boolean "is_us_export"
    t.string "biospec_retention"
    t.text "biospec_description"
    t.string "ipd_time_frame"
    t.string "ipd_access_criteria"
    t.string "ipd_url"
    t.string "plan_to_share_ipd"
    t.string "plan_to_share_ipd_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disposition_first_submitted_date"], name: "index_studies_on_disposition_first_submitted_date"
    t.index ["enrollment_type"], name: "index_studies_on_enrollment_type"
    t.index ["last_known_status"], name: "index_studies_on_last_known_status"
    t.index ["last_update_submitted_date"], name: "index_studies_on_last_update_submitted_date"
    t.index ["last_update_submitted_qc_date"], name: "index_studies_on_last_update_submitted_qc_date"
    t.index ["nct_id"], name: "index_studies_on_nct_id", unique: true
    t.index ["overall_status"], name: "index_studies_on_overall_status"
    t.index ["phase"], name: "index_studies_on_phase"
    t.index ["primary_completion_date_type"], name: "index_studies_on_primary_completion_date_type"
    t.index ["results_first_submitted_date"], name: "index_studies_on_results_first_submitted_date"
    t.index ["results_first_submitted_qc_date"], name: "index_studies_on_results_first_submitted_qc_date"
    t.index ["source"], name: "index_studies_on_source"
    t.index ["study_first_submitted_date"], name: "index_studies_on_study_first_submitted_date"
    t.index ["study_first_submitted_qc_date"], name: "index_studies_on_study_first_submitted_qc_date"
    t.index ["study_type"], name: "index_studies_on_study_type"
  end

  create_table "study_references", id: :serial, force: :cascade do |t|
    t.string "nct_id"
    t.string "pmid"
    t.string "reference_type"
    t.text "citation"
    t.index ["nct_id"], name: "index_study_references_on_nct_id"
    t.index ["reference_type"], name: "index_study_references_on_reference_type"
  end

  create_table "tagged_terms", force: :cascade do |t|
    t.integer "project_id"
    t.string "identifier"
    t.string "tag"
    t.string "term"
    t.string "year"
    t.string "term_type"
    t.index ["identifier"], name: "index_proj_tag.tagged_terms_on_identifier"
    t.index ["tag"], name: "index_proj_tag.tagged_terms_on_tag"
    t.index ["term"], name: "index_proj_tag.tagged_terms_on_term"
    t.index ["term_type"], name: "index_proj_tag.tagged_terms_on_term_type"
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
