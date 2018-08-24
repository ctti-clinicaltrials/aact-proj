class CreateProjTagTables < ActiveRecord::Migration[5.2]
  def change

    create_table "proj_tag.categorized_terms" do |t|
      t.integer 'project_id'
      t.string  'identifier'
      t.string  'category'
      t.string  'term'
      t.string  'year'
      t.string  'term_type'
    end

    create_table 'proj_tag.analyzed_mesh_terms' do |t|
      t.string  'qualifier'
      t.string  'identifier'
      t.string  'term'
      t.string  'downcase_term'
      t.string  'description'
    end

    create_table 'proj_tag.analyzed_free_text_terms' do |t|
      t.string  'identifier'
      t.string  'term'
      t.string  'downcase_term'
    end

    add_index 'proj_tag.categorized_terms', :identifier
    add_index 'proj_tag.categorized_terms', :category
    add_index 'proj_tag.categorized_terms', :term_type
    add_index 'proj_tag.analyzed_mesh_terms', :qualifier
    add_index 'proj_tag.analyzed_mesh_terms', :description
    add_index 'proj_tag.analyzed_mesh_terms', :term
    add_index 'proj_tag.analyzed_mesh_terms', :downcase_term
    add_index 'proj_tag.analyzed_free_text_terms', :term
    add_index 'proj_tag.analyzed_free_text_terms', :downcase_term

  end

end
