class Project < ActiveRecord::Base
  has_many :attachments,  :dependent => :destroy
  has_many :datasets,     :dependent => :destroy
  has_many :publications, :dependent => :destroy
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  def self.project_list
    ['ProjAnderson::ProjectInfo']
  end

  def self.populate_all
    self.project_list.each{ |proj_class| new.populate(proj_class) }
  end

  def populate(proj_class)
    new_proj = Project.new( proj_class.constantize.meta_info )
    puts  "Populating #{new_proj.name}..."
    reset_schema(new_proj)

    proj_class.constantize.attachments.each{ |a|
      file = Rack::Test::UploadedFile.new(a[:file_name], a[:file_type])
      new_proj.attachments << Attachment.create_from(file)
    }

    proj_class.constantize.datasets.each{ |ds|
      new_proj.datasets << Dataset.create(ds)
    }

    proj_class.constantize.publications.each{ |p|
      new_proj.publications << Publication.create(p)
    }

    new_proj.save!
    proj_class.constantize.load_project_tables

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

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |uc|
        csv << uc.attributes.values_at(*column_names)
      end
    end
  end

end

