module Proj2015Compliance
  class AnalyzedStudy < ActiveRecord::Base

    def populate
      dir="#{Rails.public_path}/incoming"
      self.populate_from_file("#{dir}/2015_compliance.xlsx")
    end

    def self.populate_from_file(file_name)
      data = Roo::Spreadsheet.open(file_name)
      fn = file_name.split('/').last.split('_')
      header = data.first.map(&:downcase)

      (2..data.last_row).each  {|i|
        row = Hash[[header, data.row(i)].transpose.downcase]
        if !row['nct_id'].blank?
                create(
                  :nct_id       => row['nct_id'],
                  :url          => row['url'],
                  :brief_title  => row['brief_title'],
                  :start_month  => row['start_month'],
                  :start_year   => row['start_year'],
                  :overall_status  => row['overall_status'],
                ).save!
        end
      }
    end

  end
end
