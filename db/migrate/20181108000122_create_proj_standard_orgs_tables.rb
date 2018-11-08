class CreateProjStandardOrgsTables < ActiveRecord::Migration[5.2]

  def up

    execute "CREATE SCHEMA proj_standard_orgs;"
    create_table "proj_standard_orgs.organizations" do |t|
      t.string  'name'
      t.string  'lowercase_name'
    end

    create_table "proj_standard_orgs.synonyms" do |t|
      t.string  'name'
      t.string  'preferred_name'
      t.string  'lowercase_name'
      t.string  'lowercase_preferred_name'
    end

  end

  def down
    execute "DROP SCHEMA proj_standard_orgs CASCADE;"
  end

end
