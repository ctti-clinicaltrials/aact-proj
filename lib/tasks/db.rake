#  The database belongs to the 'aact' application.  Don't ever drop it.  Just drop our schema in it.
Rake::Task["db:drop"].clear
Rake::Task["db:create"].clear

namespace :db do

  desc 'Never drop the AACT database! (Only drop project-related schemas)'
  task drop: [:environment] do
    puts "Dropping schema proj, proj_anderson & proj_standard_orgs, proj_tag_nephrology..."
    con=ActiveRecord::Base.establish_connection(ENV['AACT_PROJ_DATABASE_URL']).connection
    Project.schema_name_array.each {|schema_name|
      exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = '#{schema_name}';").values
      con.execute("DROP SCHEMA #{schema_name} CASCADE;") if !exists.empty?
    }
    exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'proj';").values
    con.execute("DROP SCHEMA proj CASCADE;") if !exists.empty?
    con.execute("DELETE FROM schema_migrations WHERE version like '%22';")   # These are the project migrations.
    con.reset!
    Project.set_search_path_non_proj_schemas
  end

  desc 'Do not create the AACT database; create project-related schemas'
  task create: [:environment] do
    puts "Creating schema proj, proj_anderson & proj_standard_orgs, proj_tag_nephrology..."
    # To get proj setup, need to login as the AACT primary superuser - they will give the AACT_PROJ_DB_SUPER_USERNAME privs
    con=ActiveRecord::Base.establish_connection(ENV['AACT_PROJ_DATABASE_URL']).connection
    con.execute("GRANT CREATE ON DATABASE #{ENV['AACT_PROJ_DATABASE']} TO #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
    Project.schema_name_array.each {|schema_name|
      exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = '#{schema_name}';").values
      con.execute("CREATE SCHEMA #{schema_name};") if exists.empty?
      con.execute("GRANT USAGE ON SCHEMA #{schema_name} to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
      con.execute("GRANT USAGE ON SCHEMA #{schema_name} TO public;")
      con.execute("GRANT CREATE ON SCHEMA #{schema_name} to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
      con.execute("GRANT SELECT ON ALL TABLES IN SCHEMA #{schema_name} TO public;")
    }
    exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'proj';").values
    con.execute("CREATE SCHEMA proj;") if exists.empty?
    con.execute("GRANT USAGE ON SCHEMA proj to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
    con.execute("GRANT USAGE ON SCHEMA proj TO public;")
    con.execute("GRANT CREATE ON SCHEMA proj to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
    con.execute("GRANT SELECT ON ALL TABLES IN SCHEMA proj TO public;")
    con.reset!
    Project.set_search_path_all_schemas
  end

  task :migrate do
    # make rails unaware of other schemas. If rails detects an existing schema_migrations table,
    # it will use it - but we need a proj-specific schema_migrations table in our proj schema
    # Temporarily get rid of schema_migration table or it will use the one in the public schema.
    Project.set_search_path_proj_schemas
    Rake::Task["db:migrate"].invoke
    Project.set_search_path_all_schemas
    # Afterwards, put search_path back to normal.
    Project.set_search_path_all_schemas
  end

  task :seed do
    con=ActiveRecord::Base.establish_connection(ENV['AACT_PROJ_DATABASE_URL']).connection
    # Make sure it doesn't try to populate any tables in ctgov
    Project.set_search_path_proj_schemas
    Rake::Task["db:seed"].invoke
    # Afterwards, put search_path back to normal.
    Project.set_search_path_all_schemas
  end

  task :rollback do
    # make rails unaware of any non-project schemas
    Project.set_search_path_proj_schemas
    Rake::Task["db:rollback"].invoke
    # now put ctgov & public schemas back in the searh path
    Project.set_search_path_all_schemas
  end

  task :setup do
    Rake::Task["db:setup"].invoke
  end

  task :version do
    Rake::Task["db:version"].invoke
  end

  namespace :schema do
    task :load do
      Rake::Task["db:schema:load"].invoke
    end
  end

  namespace :test do
    task :prepare do
      Rake::Task["db:test:prepare"].invoke
    end
  end

end
