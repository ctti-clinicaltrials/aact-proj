#  The database belongs to the 'aact' application.  Don't ever drop it.  Just drop our schema in it.
Rake::Task["db:drop"].clear
Rake::Task["db:create"].clear

namespace :db do

  desc 'Never drop the AACT database! (Only drop project-related schemas)'
  task drop: [:environment] do
    puts "Dropping schema proj, proj_anderson & proj_tag..."
    con=ActiveRecord::Base.establish_connection(ENV['AACT_PROJ_DATABASE_URL']).connection
    exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'proj';").values
    con.execute('DROP SCHEMA proj CASCADE;') if !exists.empty?
    exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'proj_anderson';").values
    con.execute('DROP SCHEMA proj_anderson CASCADE;') if !exists.empty?
    exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'proj_tag';").values
    con.execute('DROP SCHEMA proj_tag CASCADE;') if !exists.empty?
    con.execute("ALTER ROLE #{ENV['AACT_PROJ_DB_SUPER_USERNAME']} IN DATABASE aact SET search_path TO ctgov, public;")
    con.reset!
  end

  desc 'Do not create the AACT database; create project-related schemas'
  task create: [:environment] do
    puts "Creating schema proj, proj_anderson & proj_tag..."
    # To get proj setup, need to login as the AACT primary superuser - they will give the AACT_PROJ_DB_SUPER_USERNAME privs
    con=ActiveRecord::Base.establish_connection(ENV['AACT_PROJ_DATABASE_URL']).connection
    con.execute("GRANT CREATE ON DATABASE aact TO #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")

    exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'proj';").values
    con.execute('CREATE SCHEMA proj;') if exists.empty?
    exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'proj_anderson';").values
    con.execute('CREATE SCHEMA proj_anderson;') if exists.empty?
    exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'proj_tag';").values
    con.execute('CREATE SCHEMA proj_tag;') if exists.empty?

    con.execute("grant usage on schema proj to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
    con.execute("grant create on schema proj to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
    con.execute("grant select on all tables in schema proj to public;")

    con.execute("grant usage on schema proj_anderson to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
    con.execute("grant create on schema proj_anderson to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
    con.execute("grant select on all tables in schema proj_anderson to public;")

    con.execute("grant usage on schema proj_tag to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
    con.execute("grant create on schema proj_tag to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
    con.execute("grant select on all tables in schema proj_tag to public;")

    con.execute("ALTER ROLE #{ENV['AACT_PROJ_DB_SUPER_USERNAME']} IN DATABASE aact SET search_path TO proj, proj_anderson, proj_tag, ctgov, public;")
    con.reset!
  end

  task :migrate do
    # make rails unaware of other schemas. If rails detects an existing schema_migrations table,
    # it will use it - but we need a proj-specific schema_migrations table in our proj schema
    con=ActiveRecord::Base.establish_connection(ENV['AACT_PROJ_DATABASE_URL']).connection
    con.execute("ALTER ROLE #{ENV['AACT_PROJ_DB_SUPER_USERNAME']} IN DATABASE aact SET search_path TO proj, proj_anderson, proj_tag;")
    con.reset!
    Rake::Task["db:migrate"].invoke
    # now put ctgov & public schemas back in the searh path
    con = ActiveRecord::Base.connection
    con.execute("ALTER ROLE #{ENV['AACT_PROJ_DB_SUPER_USERNAME']} IN DATABASE aact SET search_path TO proj, proj_anderson, proj_tag, ctgov, public;")
    con.reset!
  end

  task :seed do
    con = ActiveRecord::Base.connection
    con.execute("ALTER ROLE #{ENV['AACT_PROJ_DB_SUPER_USERNAME']} IN DATABASE aact SET search_path TO proj, proj_anderson, proj_tag;")
    con.reset!
    Rake::Task["db:seed"].invoke
    # now put ctgov & public schemas back in the searh path
    con = ActiveRecord::Base.connection
    con.execute("ALTER ROLE #{ENV['AACT_PROJ_DB_SUPER_USERNAME']} IN DATABASE aact SET search_path TO proj, proj_anderson, proj_tag, ctgov, public;")
    con.reset!
  end

  task :rollback do
    # make rails unaware of any other schema in the database
    con=ActiveRecord::Base.connection
    con.execute("ALTER ROLE #{ENV['AACT_PROJ_DB_SUPER_USERNAME']} IN DATABASE aact SET search_path TO proj, proj_anderson, proj_tag;")
    con.reset!
    Rake::Task["db:rollback"].invoke
    # now put ctgov & public schemas back in the searh path
    con = ActiveRecord::Base.connection
    con.execute("ALTER ROLE #{ENV['AACT_PROJ_DB_SUPER_USERNAME']} IN DATABASE aact SET search_path TO proj, proj_anderson, proj_tag, ctgov, public;")
    con.reset!
  end

  task :seed do
    Rake::Task["db:seed"].invoke
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
