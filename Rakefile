# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks
task(:default).clear
task default: [:spec]

namespace :db do
  def set_search_path
    puts "Setting search path to ctgov..."
    con=ActiveRecord::Base.connection
    exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'proj';")
    if exists.first != nil
      con.execute("DROP SCHEMA proj CASCADE;")
    end
    exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'proj_tag';")
    if exists.first != nil
      con.execute("DROP SCHEMA proj_tag CASCADE;")
    end

    con.execute("CREATE SCHEMA proj;")
    con.execute("CREATE SCHEMA proj_tag;")
    con.execute("alter role #{ENV['AACT_DB_SUPER_USERNAME']} set search_path to proj, proj_tag;")
    con.execute("grant usage on schema proj to #{ENV['AACT_DB_SUPER_USERNAME']};")
    con.execute("grant create on schema proj to #{ENV['AACT_DB_SUPER_USERNAME']};")
    con.execute("grant usage on schema proj_tag to #{ENV['AACT_DB_SUPER_USERNAME']};")
    con.execute("grant create on schema proj_tag to #{ENV['AACT_DB_SUPER_USERNAME']};")
    con.reset!
  end

  task :before_set_search_path do
    before { set_search_path }
  end

  task :after_set_search_path do
    at_exit { set_search_path }
  end

end

Rake::Task['db:create'].enhance(['db:after_set_search_path'])


if Rails.env != 'production'
  begin
    task(:spec).clear
    RSpec::Core::RakeTask.new(:spec) do |t|
      t.verbose = false
    end
  rescue
  end
end

task
