class CreateProjTagMocTables < ActiveRecord::Migration[5.2]

  def up

    execute "CREATE SCHEMA proj_tag_moc;"
    execute "GRANT USAGE ON SCHEMA proj_tag_moc to read_only;"
    execute "GRANT SELECT ON ALL TABLES IN SCHEMA proj_tag_moc TO read_only;"

    create_table "proj_tag_moc.tagged_terms" do |t|
      t.string  'tag'
      t.string  'term'
      t.string  'term_type'
    end

    create_table "proj_tag_moc.analyzed_studies" do |t|
      t.string  'nct_id'
      t.string  :overall_status
      t.string  :phase
      t.string  :url
      t.string  :brief_title
      t.date    :start_date
      t.string  :start_date_type
      t.date    :primary_completion_date
      t.string  :primary_completion_date_type
      t.string  :acronym
      t.string  :brief_title
      t.string  :source
      t.string  :number_of_arms
      t.string  :sponsors
      t.string  :group_types
      t.string  :enrollment
      t.string  :enrollment_type
      t.boolean  :has_dmc
      t.boolean  :healthy_volunteers
      t.string  :gender
      t.string  :gender_based
      t.string  :keywords
      t.string  :interventions
      t.string  :baseline_population
      t.string  :limitations_and_caveats
      t.integer  :actual_duration
      t.boolean  :were_results_reported
      t.integer  :months_to_report_results
      t.boolean  :has_us_facility
      t.integer  :number_of_facilities
      t.string  :facilities
      t.string  :states
      t.string  :countries
      t.integer  :minimum_age_num
      t.string  :minimum_age_unit
      t.integer  :maximum_age_num
      t.string  :maximum_age_unit
      t.string  :allocation
      t.string  :intervention_model
      t.string  :intervention_types
      t.string  :primary_purpose
      t.string  :masking
    end

  end

  def down
    execute "DROP SCHEMA proj_tag_moc CASCADE;"
  end

end
