class CreateProjResultsReportingTables < ActiveRecord::Migration[5.2]

  def up

    execute "CREATE SCHEMA proj_results_reporting;"
    execute "GRANT USAGE ON SCHEMA proj_results_reporting to read_only;"
    execute "GRANT SELECT ON ALL TABLES IN SCHEMA proj_results_reporting TO read_only;"
    create_table "proj_results_reporting.analyzed_studies" do |t|
      t.string  'nct_id'
      t.string  'url'
      t.string  'brief_title'
      t.string  'start_month'
      t.integer 'start_year'
      t.string  'overall_status'
      t.string  'p_completion_month'
      t.integer 'p_completion_year'
      t.string  'completion_month'
      t.integer 'completion_year'
      t.string  'verification_month'
      t.integer 'verification_year'
      t.integer 'p_comp_mn'
      t.integer 'p_comp_yr'
      t.integer 'received_year'
      t.integer 'mntopcom'
      t.integer 'enrollment'
      t.integer 'number_of_arms'
      t.string  'allocation'
      t.string  'masking'
      t.string  'phase'
      t.string  'primary_purpose'
      t.string  'sponsor_name'
      t.string  'agency_class'
      t.string  'collaborator_names'
      t.string  'funding'
      t.string  'responsible_party_type'
      t.string  'responsible_party_organization'
      t.string  'us_coderc'
      t.string  'oversight'
      t.string  'behavioral'
      t.string  'biological'
      t.string  'device'
      t.string  'dietsup'
      t.string  'drug'
      t.string  'genetic'
      t.string  'procedure'
      t.string  'radiation'
      t.string  'otherint'
      t.string  'intervg1'
      t.string  'results'
      t.string  'resultsreceived_month'
      t.string  'resultsreceived_year'
      t.date    'firstreceived_results_dt'
      t.integer 't2result'
      t.integer 't2result_imp'
      t.integer 't2resmod'
      t.string  'results12'
      t.string  'delayed'
      t.date    'dr_received_dt'
      t.boolean 'mn2delay'
      t.boolean 'delayed12'
    end

  end

  def down
    execute "DROP SCHEMA proj_results_reporting CASCADE;"
  end

end
