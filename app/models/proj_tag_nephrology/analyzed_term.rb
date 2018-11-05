module ProjTagNephrology
  class AnalyzedTerm < ActiveRecord::Base
    self.table_name = 'proj_tag_nephrology.analyzed_terms'

    def self.populate
      file_name="#{Rails.public_path}/attachments/proj_tag_nephrology_analyzed_terms.xlsx"
      self.populate_from_file(file_name)
    end

    def self.populate_from_file(file_name)
      destroy_all
      data = Roo::Spreadsheet.open(file_name).sheet("Analysis Data")
      header = data.first.compact.map(&:downcase)

      (2..data.last_row).each  {|i|
        row = Hash[[header, data.row(i)].transpose]
        create(:term => row['term'].downcase).save!  if !row['term'].blank?
      }
    end

  end
end
