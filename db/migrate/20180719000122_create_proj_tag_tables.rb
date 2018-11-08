class CreateProjTagTables < ActiveRecord::Migration[5.2]

  def up

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
