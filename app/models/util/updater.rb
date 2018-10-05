module Util
  class Updater

    attr_accessor :con, :pub_con

    def run
      populate_mesh_tables
      populate_tagged_terms
      populate_project_anderson
  #    SanityChecker.new.run
  #    dump_database
    end

    def populate_project_anderson
      proj= Project.new( ProjAnderson::ProjectInfo.meta_info )
      puts  proj.name
      remove_existing(proj)

      ProjAnderson::ProjectInfo.datasets.each{ |ds|
        proj.datasets << Dataset.create(ds)
      }

      ProjAnderson::ProjectInfo.publications.each{ |p|
        proj.publications << Publication.create(p)
      }

      ProjAnderson::ProjectInfo.attachments.each{ |a|
        file = Rack::Test::UploadedFile.new(a[:file_name], a[:file_type])
        proj.attachments << Attachment.create_from(file)
      }
      ProjAnderson::AnalyzedStudy.populate
      proj.save!
    end

    def remove_existing(proj)
      #  TODO:  Drop & recreate schema too?
      Project.where('schema_name=?',proj.schema_name).each {|p|  p.destroy }
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


    def pub_con
      @pub_con ||= PublicBase.establish_connection(ENV["AACT_PUBLIC_DATABASE_URL"]).connection
    end

    def public_db_name
      ENV['AACT_PUBLIC_DATABASE_NAME']
    end

  end
end
