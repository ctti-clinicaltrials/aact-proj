class CreateProjCdekStandardOrgsTables < ActiveRecord::Migration[5.2]

  def up

    execute "CREATE SCHEMA proj_cdek_standard_orgs;"
    execute "GRANT USAGE ON SCHEMA proj_cdek_standard_orgs to read_only;"
    execute "GRANT SELECT ON ALL TABLES IN SCHEMA proj_cdek_standard_orgs TO read_only;"
    create_table "proj_cdek_standard_orgs.cdek_organizations" do |t|
      t.string  'name'
      t.string  'lowercase_name'
    end

    create_table "proj_cdek_standard_orgs.cdek_synonyms" do |t|
      t.string  'name'
      t.string  'preferred_name'
      t.string  'lowercase_name'
      t.string  'lowercase_preferred_name'
    end

  end

  def down
    execute "DROP SCHEMA proj_cdek_standard_orgs CASCADE;"
  end

end
