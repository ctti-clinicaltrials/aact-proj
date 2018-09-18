class CreateProj2015ComplianceTables < ActiveRecord::Migration[5.2]

  def down
    drop_table proj_2015_compliance.analyzed_studies;
    execute "DROP SCHEMA IF EXISTS proj_2015_compliance;"
    execute "ALTER ROLE proj SET search_path to ctgov, proj, proj_tag;"
  end

  def up
    execute "CREATE SCHEMA IF NOT EXISTS proj_2015_compliance;"
    execute "ALTER ROLE proj SET search_path to ctgov, proj, proj_tag, proj_2015_compliance"

    create_table "proj_2015_compliance.analyzed_studies" do |t|
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

    add_index 'proj_2015_compliance.analyzed_studies', :agency_class
    add_index 'proj_2015_compliance.analyzed_studies', :funding
    add_index 'proj_2015_compliance.analyzed_studies', :overall_status
    add_index 'proj_2015_compliance.analyzed_studies', :phase
    add_index 'proj_2015_compliance.analyzed_studies', :masking
    add_index 'proj_2015_compliance.analyzed_studies', :primary_purpose

  end

end
