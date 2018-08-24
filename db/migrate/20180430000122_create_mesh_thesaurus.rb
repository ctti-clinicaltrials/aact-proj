class CreateMeshThesaurus < ActiveRecord::Migration[5.2]

  def change

    create_table 'proj.y2010_mesh_terms' do |t|
      t.string  'qualifier'
      t.string  'tree_number'
      t.string  'description'
      t.string  'mesh_term'
      t.string  'downcase_mesh_term'
    end

    create_table 'proj.y2016_mesh_terms' do |t|
      t.string  'qualifier'
      t.string  'tree_number'
      t.string  'description'
      t.string  'mesh_term'
      t.string  'downcase_mesh_term'
    end

    create_table 'proj.y2016_mesh_headings' do |t|
      t.string  'qualifier'
      t.string  'heading'
      t.string  'subcategory'
    end

    add_index 'proj.y2010_mesh_terms', :qualifier
    add_index 'proj.y2010_mesh_terms', :description
    add_index 'proj.y2010_mesh_terms', :mesh_term
    add_index 'proj.y2010_mesh_terms', :downcase_mesh_term

    add_index 'proj.y2016_mesh_terms', :qualifier
    add_index 'proj.y2016_mesh_terms', :description
    add_index 'proj.y2016_mesh_terms', :mesh_term
    add_index 'proj.y2016_mesh_terms', :downcase_mesh_term
    add_index 'proj.y2016_mesh_headings', :qualifier

  end
end
