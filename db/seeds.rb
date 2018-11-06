# This defines all commands to populate the AACT Projects system
# Projects are stored in their own database schema.  The process drops & recreates these project schemas
# then runs the project migration file to create project-related table(s) in the project's schema

con=ActiveRecord::Base.establish_connection(ENV['AACT_PROJ_DATABASE_URL']).connection
con.execute("ALTER ROLE #{ENV['AACT_PROJ_DB_SUPER_USERNAME']} IN DATABASE  #{ENV['AACT_PROJ_DATABASE']} SET search_path TO proj, proj_tag_nephrology, proj_anderson, proj_tag, ctgov, public;")
con.reset!
Project.populate_all
#Util::Updater.new.populate_mesh_tables
