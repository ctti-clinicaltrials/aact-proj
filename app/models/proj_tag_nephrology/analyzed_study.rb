module ProjTagNephrology
  class AnalyzedStudy < ActiveRecord::Base
    self.table_name = 'proj_tag_nephrology.analyzed_studies'

    def self.populate
      file_name = ProjTagNephrology::ProjectInfo.datasets.select{|ds| ds[:table_name] == 'analyzed_studies'}.first[:file_name]
      self.populate_from_file(file_name)
    end

    def self.populate_from_file(file_name)
      connection.execute("TRUNCATE TABLE #{table_name};")
      data = Roo::Spreadsheet.open(file_name).sheet("Analysis Data")
      header = data.first.compact.map(&:downcase)

      (2..data.last_row).each  {|i|
        row = Hash[[header, data.row(i)].transpose]
        if !row['nct_id'].blank?
          create(
            :nct_id                   => row['nct_id'].try(:strip),
            :brief_title              => row['brief_title'].try(:strip),
            :keywords                 => row['keywords'].try(:strip),
            :conditions               => row['conditions'].try(:strip),
            :mesh_terms               => row['mesh_terms'].try(:strip),
          ).save!
        end
      }
    end

  end
end
