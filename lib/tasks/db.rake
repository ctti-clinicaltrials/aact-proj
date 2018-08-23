#  The database belongs to the 'aact' application.  Don't ever drop it.  Just drop our schema in it.
Rake::Task["db:drop"].clear
Rake::Task["db:create"].clear

namespace :db do

  desc 'Never drop the AACT database! (Only drop project-related schemas)'
  task drop: [:environment] do
    puts "Dropping schema projects & project1..."
    con = ActiveRecord::Base.connection
    con.execute('DROP SCHEMA IF EXISTS projects CASCADE;')
    con.execute('DROP SCHEMA IF EXISTS project1 CASCADE;')
    #con.execute("alter role ctti set search_path to ctgov, lookup, public;")
    con.reset!
  end

  desc 'Do not create the AACT database; create project-related schemas'
  task create: [:environment] do
    puts "Creating schema projects & project1..."
    con = ActiveRecord::Base.connection
    con.execute('CREATE SCHEMA IF NOT EXISTS projects;')
    con.execute('CREATE SCHEMA IF NOT EXISTS project1;')
    con.execute("alter role ctti set search_path to projects, project1;")

    con.execute("grant usage on schema projects to ctti;")
    con.execute("grant create on schema projects to ctti;")
    con.execute("grant select on all tables in schema projects to public;")

    con.execute("grant usage on schema project1 to ctti;")
    con.execute("grant create on schema project1 to ctti;")
    con.execute("grant select on all tables in schema project1 to public;")
    #con.execute("alter role ctti set search_path to ctgov, projects, project1, lookup, public;")
    con.reset!
  end

  task :migrate do
    # make rails unaware of other schemas. If rails detects an existing schema_migrations table,
    # it will use it - but we need a proj-specific schema_migrations table in our proj schema
    con = ActiveRecord::Base.connection
    con.execute("alter role ctti set search_path to projects, project1;")
    con.reset!
    Rake::Task["db:migrate"].invoke
    # now put ctgov & public schemas back in the searh path
    con = ActiveRecord::Base.connection
    con.execute("alter role ctti set search_path to ctgov, projects, project1, lookup, public;")
    con.reset!
  end

  task :seed do
    con = ActiveRecord::Base.connection
    con.execute("alter role ctti set search_path to projects, project1;")
    con.reset!
    Rake::Task["db:seed"].invoke
    # now put ctgov & public schemas back in the searh path
    con = ActiveRecord::Base.connection
    con.execute("alter role ctti set search_path to ctgov, projects, project1, lookup, public;")
    con.reset!
  end

  task :rollback do
    # make rails unaware of any other schema in the database
    con=ActiveRecord::Base.connection
    con.execute("alter role ctti set search_path to projects, project1;")
    con.reset!
    Rake::Task["db:rollback"].invoke
    # now put ctgov & public schemas back in the searh path
    con = ActiveRecord::Base.connection
    con.execute("alter role ctti set search_path to ctgov, projects, project1, lookup, public;")
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
