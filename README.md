# README

AACT Data Sharing - We are sharing the data from projects that have used AACT as a data source.


* Ruby version: 2.4.5

* System dependencies:  AACT public database at aact-db.ctti-clinicaltrials.org:5432

* Configuration

* Each data share project has a directory under app/models & the project_info.rb file defines all properties for the project

* Database creation:  A database schema is created for each data share project.

* Database initialization:  It does not drop or create the database.  It only drops/creates project-related schemas.

* Deployment instructions
Go into your .bash_profile and uncomment only the section for aact-proj Rails.env = test

Open a new terminal

```bash
bundle exec rake db:drop RAILS_ENV=test
bundle exec rake db:create RAILS_ENV=test
bundle exec rake db:migrate RAILS_ENV=test
bundle exec rake db:seed RAILS_ENV=test
bundle exec rspec
```

Go into your .bash_profile and uncomment only the section for aact-proj Rails.env != test

Open a new terminal

```bash
bin/rails db:environment:set RAILS_ENV=development
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```
