module ProjTagCardiology
  class TaggedTerm < ActiveRecord::Base
    self.table_name = 'proj_tag_cardiology.tagged_terms'

    def self.populate
      AciveRecord::Base.connection.execute "CREATE OR REPLACE VIEW proj_tag_cardiology.tagged_terms AS SELECT * FROM proj_tag.tagged_terms WHERE tag='cardiology'"
    end

  end
end
