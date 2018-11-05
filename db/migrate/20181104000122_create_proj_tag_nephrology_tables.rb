class CreateProjTagNephrologyTables < ActiveRecord::Migration[5.2]

  def up
    execute "CREATE SCHEMA IF NOT EXISTS proj_tag_nephrology;"
    # set search path so that this doesn't get confused about other schemas

    create_table "proj_tag_nephrology.tagged_terms" do |t|
      t.integer 'project_id'
      t.string  'identifier'
      t.string  'tag'
      t.string  'term'
      t.string  'year'
      t.string  'term_type'
    end

    create_table "proj_tag_nephrology.analyzed_studies" do |t|
      t.integer 'nct_id'
      t.string  'hyperlink'
      t.string  'brief_title'
      t.string  'keywords'
      t.string  'conditions'
      t.string  'mesh_terms'
    end

    add_index 'proj_tag_nephrology.tagged_terms', :identifier
    add_index 'proj_tag_nephrology.tagged_terms', :term
    add_index 'proj_tag_nephrology.tagged_terms', :tag
    add_index 'proj_tag_nephrology.tagged_terms', :term_type

  end

  def down
    drop_table proj_tag_nephrology.tagged_terms;
    execute "DROP SCHEMA IF EXISTS proj_tag_nephrology;"
  end

end
