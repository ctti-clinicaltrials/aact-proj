class CreateProjectTables < ActiveRecord::Migration[5.2]
  def change

    create_table "projects.use_cases" do |t|
      t.string  'status'  # public or not?
      t.date    'start_date'
      t.date    'completion_date'
      t.string  'schema_name'
      t.string  'name'
      t.integer 'year'
      t.string  'brief_summary'
      t.string  'investigators'
      t.string  'organizations'
      t.string  'url'
      t.text    'description'
      t.text    'protocol'
      t.text    'issues'
      t.text    'study_selection_criteria'
      t.string  'submitter_name'
      t.string  'contact_info'
      t.string  'email'
      t.binary  'image'
      t.timestamps null: false
    end

    create_table "projects.attachments" do |t|
      t.integer 'use_case_id'
      t.string 'file_name'
      t.string 'content_type'
      t.binary 'file_contents'
      t.boolean 'is_image'
      t.timestamps null: false
    end

    create_table "projects.publications" do |t|
      t.integer 'use_case_id'
      t.string 'name'
      t.string 'url'
      t.text 'description'
      t.timestamps null: false
    end

    create_table "projects.datasets" do |t|
      t.integer 'use_case_id'
      t.string 'dataset_type'
      t.string 'name'
      t.string 'url'
      t.text 'description'
      t.timestamps null: false
    end

    add_index "projects.use_cases", :investigators
    add_index "projects.use_cases", :organizations
    add_index "projects.use_cases", :start_date
    add_index "projects.use_cases", :completion_date
    add_index "projects.use_cases", :year

  end

end
