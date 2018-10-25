class Project < ActiveRecord::Base
  has_many :publications, :dependent => :destroy
  has_many :datasets,     :dependent => :destroy  # data artifacts - typically saved as tables in the project's db schema. (May include attachment.)
  has_many :attachments,  :dependent => :destroy  # non-dataset attachments like images & full-text documents

  def self.project_list
    # A list of all project modules currently in AACT.
    # Each module (in app/models) and encapsulates all info about the project.
    [ 'ProjAnderson', 'ProjTag', 'ProjSummaryTrends', 'ProjClinwiki', 'ProjEeg' ]
  end

  def self.populate_all
    self.project_list.each{ |proj_module| new.populate(proj_module) }
  end

  def populate(proj_module)
    proj_info="#{proj_module}::ProjectInfo".constantize
    new_proj = Project.new( proj_info.meta_info )
    Project.where('name=?',new_proj.name).each{|p| p.destroy }
    puts  "Populating #{new_proj.name}..."
    reset_schema(new_proj) if new_proj.migration_file_name  # only need a schema if the project has tables to contribute to AACT

    proj_info.publications.each{ |p| new_proj.publications << Publication.create(p) }

    proj_info.attachments.each{ |a|
      file = Rack::Test::UploadedFile.new(a[:file_name], a[:file_type])
      new_proj.attachments << Attachment.create_from(file)
    }
    proj_info.datasets.each{ |ds|
      file = Rack::Test::UploadedFile.new(ds[:file_name], ds[:file_type])
      new_proj.datasets << Dataset.create_from(ds, file)
    }
    new_proj.save!
    proj_info.load_project_tables

  end

  def reset_schema(proj_info)
    Project.where('schema_name=?',proj_info.schema_name).each {|p|  p.destroy }
    con=ActiveRecord::Base.establish_connection(ENV['AACT_PROJ_DATABASE_URL']).connection
    exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = '#{proj_info.schema_name}';").values
    con.execute("DROP SCHEMA #{proj_info.schema_name} CASCADE;") if !exists.empty?
    con.execute("CREATE SCHEMA #{proj_info.schema_name};")
    con.execute("GRANT USAGE ON SCHEMA #{proj_info.schema_name} to public;")
    con.execute("GRANT SELECT ON ALL TABLES IN SCHEMA #{proj_info.schema_name} TO public;")
    con.execute("GRANT CREATE ON SCHEMA #{proj_info.schema_name} TO #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
    con.execute("ALTER ROLE proj IN DATABASE aact SET search_path TO #{proj_info.schema_name}")
    require(proj_info.migration_file_name)
    migration_class_name=(File.open(proj_info.migration_file_name) {|f| f.readline}).split(' ')[1]
    migration_class_name.constantize.new.up

    # TODO:  How to reset search path for the Projects superuser?
    con.execute "ALTER ROLE proj IN DATABASE aact SET search_path TO proj, proj_tag, proj_anderson, ctgov"
  end

  def image
    attachments.select{|a| a.is_image }.first
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |uc|
        csv << uc.attributes.values_at(*column_names)
      end
    end
  end

end

