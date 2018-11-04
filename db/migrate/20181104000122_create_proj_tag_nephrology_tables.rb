class CreateProjTagNephrologyTables < ActiveRecord::Migration[5.2]

  def up
    execute "CREATE SCHEMA IF NOT EXISTS proj_tag_nephrology;"
    # set search path so that this doesn't get confused about other schemas

    create_table "proj_tag_nephrology.tagged_nephrology_terms" do |t|
      t.integer 'project_id'
      t.string  'identifier'
      t.string  'tag'
      t.string  'term'
      t.string  'year'
      t.string  'term_type'
    end

    add_index 'proj_tag_nephrology.tagged_nephrology_terms', :identifier
    add_index 'proj_tag_nephrology.tagged_nephrology_terms', :term
    add_index 'proj_tag_nephrology.tagged_nephrology_terms', :tag
    add_index 'proj_tag_nephrology.tagged_nephrology_terms', :term_type

    execute <<-SQL

         CREATE OR REPLACE VIEW proj_tag_nephrology.analyzed_nephrology_studies AS
         SELECT * FROM ctgov.studies
         WHERE study_type = 'interventional';
    SQL
  end

  def down
    drop_table proj_tag_nephrology.tagged_nephrology_terms;
    execute "DROP SCHEMA IF EXISTS proj_tag_nephrology;"
  end

end
