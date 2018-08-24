class CreateProjTagTables < ActiveRecord::Migration[5.2]
  def change

    create_table "proj_tag.tagged_terms" do |t|
      t.integer 'project_id'
      t.string  'identifier'
      t.string  'tag'
      t.string  'term'
      t.string  'year'
      t.string  'term_type'
    end

    add_index 'proj_tag.tagged_terms', :identifier
    add_index 'proj_tag.tagged_terms', :term
    add_index 'proj_tag.tagged_terms', :tag
    add_index 'proj_tag.tagged_terms', :term_type

  end

end
