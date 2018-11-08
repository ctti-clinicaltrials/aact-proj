module Util
  class Updater

    attr_accessor :con

    def run
      populate_mesh_tables
      populate_tagged_terms
      Admin::Project.populate_all
  #    SanityChecker.new.run
  #    dump_database
    end

    def populate_mesh_tables
      # Load MeSH terms for 2010 & 2016
      con.execute("truncate table y2010_mesh_terms")
      Y2010MeshTerm.populate_from_file
      con.execute("truncate table y2016_mesh_terms")
      Y2016MeshTerm.populate_from_file
      con.execute("truncate table y2016_mesh_headings")
      Y2016MeshHeading.populate_from_file
    end

    def populate_tagged_terms
      #  TODO:  Refactor this to add to Project.populate_all
      con = ActiveRecord::Base.establish_connection.connection
      con.execute("truncate table tagged_terms")
      ProjTag::TaggedTerm.populate
    end

    def db_name
      con.current_database
    end

    def con
      @con ||= ActiveRecord::Base.establish_connection.connection
    end


    def public_db_name
      ENV['AACT_PUBLIC_DATABASE_NAME']
    end

    def create_schema
      # Project admin data is saved to the aact_admin database
      puts "aact_admin db:  Creating schema proj..."
      con=ActiveRecord::Base.establish_connection(ENV['AACT_PROJ_DATABASE_URL']).connection
      con.execute("GRANT CREATE ON DATABASE #{ENV['AACT_PROJ_DATABASE']} TO #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
      exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'proj';").values
      con.execute("GRANT USAGE ON SCHEMA proj to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
      con.execute("GRANT CREATE ON SCHEMA proj to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
      con.reset!
    end

  end
end
