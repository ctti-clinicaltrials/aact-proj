#Rake::Task["db:drop"].clear
#Rake::Task["db:migrate"].clear

namespace :db do

  desc 'Clear out Project tables in aact_admin & then drop projects database'
  task drop: [:environment] do
    puts "aact_admin db:  Clear out project tables..."
    con=ActiveRecord::Base.establish_connection(ENV['AACT_ADMIN_DATABASE_URL']).connection
    con.execute("TRUNCATE TABLE projects;")
    con.execute("TRUNCATE TABLE attachments;")
    con.execute("TRUNCATE TABLE datasets;")
    con.execute("TRUNCATE TABLE publications;")
    con.reset!
    #Rake::Task["db:drop"].invoke
  end

  task migrate: [:environment] do
    Rake::Task["db:migrate"].invoke
    puts "aact_proj db:  set search_path ..."
    con=ActiveRecord::Base.establish_connection(ENV['AACT_PROJ_DATABASE_URL']).connection
    con.execute("alter role proj in database aact_proj set search_path = public, #{Admin::Project.schema_name_list};")
    con.reset!
  end

end
