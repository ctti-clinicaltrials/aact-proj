#  The database belongs to the 'aact' application.  Don't ever drop it.  Just drop our schema in it.
Rake::Task["db:drop"].clear
Rake::Task["db:create"].clear

namespace :db do

  desc 'Never drop the AACT database! (Only drop project-related schemas)'
  task drop: [:environment] do
    puts "Dropping schema proj & proj_tag..."
    con = ActiveRecord::Base.connection
    begin
      con.execute('DROP SCHEMA proj CASCADE;')
    rescue
      #  if error raised cuz proj doesn't exist, just proceed. (Seems 'IF EXISTS' doesn't work on version of postgres currently on dev
    end
    begin
    con.execute('DROP SCHEMA proj_tag CASCADE;')
    rescue
    end
    #con.execute("alter role ctti set search_path to ctgov, lookup, public;")
    con.reset!
  end

  desc 'Do not create the AACT database; create project-related schemas'
  task create: [:environment] do
    puts "Creating schema proj & proj_tag..."
    con = ActiveRecord::Base.connection
    con.execute('CREATE SCHEMA proj;')
    con.execute('CREATE SCHEMA proj_tag;')
    con.execute("alter role ctti set search_path to proj, proj_tag;")

    con.execute("grant usage on schema proj to ctti;")
    con.execute("grant create on schema proj to ctti;")
    con.execute("grant select on all tables in schema proj to public;")

    con.execute("grant usage on schema proj_tag to ctti;")
    con.execute("grant create on schema proj_tag to ctti;")
    con.execute("grant select on all tables in schema proj_tag to public;")
    #con.execute("alter role ctti set search_path to ctgov, proj, proj_tag, lookup, public;")
    con.reset!
  end

  task :migrate do
    # make rails unaware of other schemas. If rails detects an existing schema_migrations table,
    # it will use it - but we need a proj-specific schema_migrations table in our proj schema
    con = ActiveRecord::Base.connection
    con.execute("alter role ctti set search_path to proj, proj_tag;")
    con.reset!
    Rake::Task["db:migrate"].invoke
    # now put ctgov & public schemas back in the searh path
    con = ActiveRecord::Base.connection
    con.execute("alter role ctti set search_path to ctgov, proj, proj_tag, lookup, public;")
    con.reset!
  end

  task :seed do
    con = ActiveRecord::Base.connection
    con.execute("alter role ctti set search_path to proj, proj_tag;")
    con.reset!
    Rake::Task["db:seed"].invoke
    # now put ctgov & public schemas back in the searh path
    con = ActiveRecord::Base.connection
    con.execute("alter role ctti set search_path to ctgov, proj, proj_tag, lookup, public;")
    con.reset!
  end

  task :rollback do
    # make rails unaware of any other schema in the database
    con=ActiveRecord::Base.connection
    con.execute("alter role ctti set search_path to proj, proj_tag;")
    con.reset!
    Rake::Task["db:rollback"].invoke
    # now put ctgov & public schemas back in the searh path
    con = ActiveRecord::Base.connection
    con.execute("alter role ctti set search_path to ctgov, proj, proj_tag, lookup, public;")
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
