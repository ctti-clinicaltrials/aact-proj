class CreateProjTagOncologyTables < ActiveRecord::Migration[5.2]

  def up

    execute "CREATE SCHEMA proj_tag_oncology;"
    execute "GRANT USAGE ON SCHEMA proj_tag_oncology to read_only;"
    execute "GRANT SELECT ON ALL TABLES IN SCHEMA proj_tag_oncology TO read_only;"
    #  Cannot create the view until the proj_tag project table has been populated.
    execute "CREATE OR REPLACE VIEW proj_tag_oncology.tagged_terms AS SELECT * FROM proj_tag.tagged_terms WHERE tag='oncology'"

    create_table "proj_tag_oncology.analyzed_studies" do |t|
      t.string  'nct_id'
      t.string  'brief_title'
      t.string  'lead_sponsor'
    end

  end

  def down
    execute "DROP SCHEMA proj_tag_oncology CASCADE;"
  end

end
