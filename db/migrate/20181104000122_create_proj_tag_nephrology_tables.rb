class CreateProjTagNephrologyTables < ActiveRecord::Migration[5.2]

  def up
    execute "CREATE SCHEMA IF NOT EXISTS proj_tag_nephrology;"
    # set search path so that this doesn't get confused about other schemas
    execute "ALTER ROLE proj IN DATABASE aact SET search_path TO proj, proj_tag_nephrology"

    create_table "proj_tag_nephrology.tagged_terms" do |t|
      t.integer 'project_id'
      t.string  'identifier'
      t.string  'tag'
      t.string  'term'
      t.string  'year'
      t.string  'term_type'
    end

    add_index 'proj_tag_nephrology.tagged_terms', :identifier
    add_index 'proj_tag_nephrology.tagged_terms', :term
    add_index 'proj_tag_nephrology.tagged_terms', :tag
    add_index 'proj_tag_nephrology.tagged_terms', :term_type

    execute <<-SQL
         ALTER ROLE proj IN DATABASE aact SET search_path TO proj_tag_nephrology, ctgov;

         CREATE OR REPLACE VIEW proj_tag_nephrology.analyzed_studies AS
         SELECT * FROM ctgov.studies
         WHERE study_type = 'interventional';
    SQL
  end

    # reset search path back so proj has access to all
    execute "ALTER ROLE proj IN DATABASE aact SET search_path TO ctgov, proj, proj_tag_nephrology, proj_tag, proj_anderson, public"
  end

  def down
    drop_table proj_tag_nephrology.tagged_terms;
    execute "DROP SCHEMA IF EXISTS proj_tag_nephrology;"
    execute "ALTER ROLE proj IN DATABASE aact SET search_path TO ctgov, proj, proj_tag, proj_anderson, public"
  end

end
