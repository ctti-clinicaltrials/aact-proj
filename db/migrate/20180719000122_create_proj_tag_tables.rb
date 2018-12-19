class CreateProjTagTables < ActiveRecord::Migration[5.2]

  def up

    execute "CREATE SCHEMA proj_tag;"
    execute "GRANT USAGE ON SCHEMA proj_tag to read_only;"
    execute "GRANT SELECT ON ALL TABLES IN SCHEMA proj_tag TO read_only;"
    create_table "proj_tag.tagged_terms" do |t|
      t.integer 'project_id'
      t.string  'identifier'
      t.string  'tag'
      t.string  'term'
      t.string  'year'
      t.string  'term_type'
    end

  end

  def down
    execute "DROP SCHEMA proj_tag CASCADE;"
  end

end
