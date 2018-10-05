class PublicBase < ActiveRecord::Base
  establish_connection(ENV["AACT_PROJ_DATABASE_URL"])
  self.abstract_class = true
end
