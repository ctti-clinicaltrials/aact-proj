module Util
  class Updater

    attr_accessor :con, :pub_con

    def run
      populate_mesh_tables
      populate_tagged_terms
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
      con = ActiveRecord::Base.establish_connection.connection
      con.execute("truncate table tagged_terms")
      ProjTag::TaggedTerm.populate
    end

    def dump_database
      psql_file_name="/aact-files/other/aact-proj-#{Time.now.strftime("%Y%m%d_%H")}.psql"
      File.delete(psql_file_name) if File.exist?(psql_file_name)
      cmd="pg_dump --no-owner --no-acl --host=localhost --username=#{ENV['DB_SUPER_USERNAME']} --schema=proj  aact_back > #{psql_file_name}"
      run_command_line(cmd)
      system cmd
      return psql_file_name
    end

    def refresh_public_db(psql_file_name)
      begin
        success_code=true
        revoke_db_privs
        terminate_db_sessions
        return nil if psql_file_name.nil?
        pub_con.execute('DROP SCHEMA IF EXISTS proj CASCADE')
        pub_con.execute('DROP SCHEMA IF EXISTS proj_tag CASCADE')
        pub_con.execute('CREATE SCHEMA proj')
        pub_con.execute('CREATE SCHEMA proj_tag')
        cmd="psql -h aact-db.ctti-clinicaltrials.org #{public_db_name} < #{psql_file} > /dev/null"
        run_command_line(cmd)

        terminate_alt_db_sessions
        pub_con.execute('DROP SCHEMA IF EXISTS proj CASCADE')
        pub_con.execute('DROP SCHEMA IF EXISTS proj_tag CASCADE')
        pub_con.execute('CREATE SCHEMA proj')
        pub_con.execute('CREATE SCHEMA proj_tag')
        cmd="psql -h aact-db.ctti-clinicaltrials.org #{public_db_name} < #{psql_file} > /dev/null"
        run_command_line(cmd)

        grant_db_privs
        return success_code
      rescue => error
        msg="#{error.message} (#{error.class} #{error.backtrace}"
        event.add_problem(msg)
        log msg
        grant_db_privs
        return false
      end
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
