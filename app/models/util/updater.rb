module Util
  class Updater

    attr_accessor :con

    def run
      populate_mesh_tables
      populate_tagged_terms
      Project.populate_all
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

  end
end
