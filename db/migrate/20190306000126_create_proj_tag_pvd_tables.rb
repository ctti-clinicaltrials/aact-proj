class CreateProjTagPvdTables < ActiveRecord::Migration[6.0]

  def up

    execute "CREATE SCHEMA proj_tag_pvd;"
    execute "GRANT USAGE ON SCHEMA proj_tag_pvd to read_only;"
    execute "GRANT SELECT ON ALL TABLES IN SCHEMA proj_tag_pvd TO read_only;"
    #  Cannot create the view until the proj_tag project table has been populated.
    execute "CREATE OR REPLACE VIEW proj_tag_pvd.tagged_terms AS SELECT * FROM proj_tag.tagged_terms WHERE tag='peripheral vascular disease'"

    create_table "proj_tag_pvd.analyzed_studies" do |t|
      t.string  'nct_id'
      t.string  'brief_title'
      t.string  'lead_sponsor'
    end

  end

  def down
    execute "DROP SCHEMA proj_tag_pvd CASCADE;"
  end

end
