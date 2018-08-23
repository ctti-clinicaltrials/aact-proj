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
    con.execute("CREATE SCHEMA IF NOT EXISTS projects;")
    con.execute("CREATE SCHEMA IF NOT EXISTS project1;")
    con.execute("alter role #{ENV['AACT_DB_SUPER_USERNAME']} set search_path to projects, project1;")
    con.execute("grant usage on schema projects to #{ENV['AACT_DB_SUPER_USERNAME']};")
    con.execute("grant create on schema projects to #{ENV['AACT_DB_SUPER_USERNAME']};")
    con.execute("grant usage on schema project1 to #{ENV['AACT_DB_SUPER_USERNAME']};")
    con.execute("grant create on schema project1 to #{ENV['AACT_DB_SUPER_USERNAME']};")
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
