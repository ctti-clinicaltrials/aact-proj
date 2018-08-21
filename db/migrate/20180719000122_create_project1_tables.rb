class CreateProject1Tables < ActiveRecord::Migration[5.2]
  def change

    create_table "project1.categorized_terms" do |t|
      t.integer 'project_id'
      t.string  'identifier'
      t.string  'term_type'
      t.string  'category'
      t.string  'year'
    end

    create_table 'project1.analyzed_mesh_terms' do |t|
      t.string  'qualifier'
      t.string  'identifier'
      t.string  'term'
      t.string  'downcase_term'
      t.string  'description'
    end

    create_table 'project1.analyzed_free_text_terms' do |t|
      t.string  'identifier'
      t.string  'term'
      t.string  'downcase_term'
    end

    create_table 'project1.clinical_categories' do |t|
      t.string  'name'
      t.string  'downcase_name'
    end

    add_index 'project1.categorized_terms', :identifier
    add_index 'project1.categorized_terms', :category
    add_index 'project1.categorized_terms', :term_type
    add_index 'project1.analyzed_mesh_terms', :qualifier
    add_index 'project1.analyzed_mesh_terms', :description
    add_index 'project1.analyzed_mesh_terms', :term
    add_index 'project1.analyzed_mesh_terms', :downcase_term
    add_index 'project1.analyzed_free_text_terms', :term
    add_index 'project1.analyzed_free_text_terms', :downcase_term

  end

end
