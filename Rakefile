# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks
task(:default).clear
task default: [:spec]

namespace :db do

  def reset_search_path
    # put back to normal so the PROJ super user can see tables in ctgov schema
    puts "Resetting search path ..."
    con=ActiveRecord::Base.establish_connection(ENV['AACT_PUBLIC_DATABASE_URL']).connection
    con.execute("ALTER ROLE #{ENV['AACT_PROJ_DB_SUPER_USERNAME']} IN DATABASE aact SET search_path TO proj, proj_anderson, proj_tag, ctgov;")
    con.reset!
  end

  task :after_set_search_path do
    at_exit { reset_search_path }
  end

end

Rake::Task['db:create'].enhance(['db:after_set_search_path'])
Rake::Task['db:migrate'].enhance(['db:after_set_search_path'])

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
