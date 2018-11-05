module ProjTagNephrology
  class AnalyzedStudy < ActiveRecord::Base
    self.table_name = 'proj_tag_nephrology.analyzed_studies'

    def self.populate
      file_name="#{Rails.public_path}/attachments/proj_tag_nephrology_studies.xlsx"
      self.populate_from_file(file_name)
    end

    def self.populate_from_file(file_name)
      destroy_all
      data = Roo::Spreadsheet.open(file_name).sheet("Analysis Data")
      header = data.first.compact.map(&:downcase)

      (2..data.last_row).each  {|i|
        row = Hash[[header, data.row(i)].transpose]
        if !row['nct_id'].blank?
          create(
            :nct_id                   => row['nct_id'],
            :brief_title              => row['brief_title'],
            :keywords                 => row['keywords'],
            :conditions               => row['conditions'],
            :mesh_terms               => row['mesh_terms'],
          ).save!
        end
      }
    end

  end
end
