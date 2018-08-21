require File.expand_path('../config/application', __FILE__)
Rails.application.load_tasks
#  This uses a schema in the Public AACT database.  Never drop/create the db; just drop/create the schema

task(:default).clear
task default: [:spec]

