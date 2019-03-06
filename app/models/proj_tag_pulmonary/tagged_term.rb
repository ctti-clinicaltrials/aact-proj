module ProjTagNephrology
  class TaggedTerm < ActiveRecord::Base
    self.table_name = 'proj_tag_nephrology.tagged_terms'

    def self.populate
      AciveRecord::Base.connection.execute "CREATE VIEW proj_tag_pulmonary.tagged_terms AS SELECT * FROM proj_tag.tagged_terms WHERE tag='pulmonary'"
    end

    def self.populate_from_file(file_name)
      connection.execute("TRUNCATE TABLE #{table_name};")
      data = Roo::Spreadsheet.open(file_name).sheet("Analysis Data")
      header = data.first.compact.map(&:downcase)

      (2..data.last_row).each  {|i|
        row = Hash[[header, data.row(i)].transpose]
        create(:term => row['term'].downcase.strip, :term_type=> row['type'].downcase.strip).save!  if !row['term'].blank?
      }
    end

  end
end
