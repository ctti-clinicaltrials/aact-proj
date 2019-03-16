module ProjTagOncology
  class TaggedTerm < ActiveRecord::Base
    self.table_name = 'proj_tag_oncology.tagged_terms'

    def self.populate
      AciveRecord::Base.connection.execute "CREATE OR REPLACE VIEW proj_tag_oncology.tagged_terms AS SELECT * FROM proj_tag.tagged_terms WHERE tag='oncology'"
    end

  end
end
