module ProjCdekStandardOrgs
  class CdekOrganization < ActiveRecord::Base
    self.table_name = 'proj_cdek_standard_orgs.cdek_organizations'

    def self.populate
      file_name="#{Rails.public_path}/attachments/proj_cdek_standard_orgs_organizations.xlsx"
      self.populate_from_file(file_name)
    end

    def self.populate_from_file(file_name)
      connection.execute("TRUNCATE TABLE #{table_name};")
      data = Roo::Spreadsheet.open(file_name).sheet("Orgs")
      header = data.first.compact.map(&:downcase)

      (2..data.last_row).each  {|i|
        row = Hash[[header, data.row(i)].transpose]
        create(
          :name            => row['name'].strip,
          :downcase_name   => row['name'].downcase.strip
        ).save!  if !row['name'].blank?
      }
    end

  end
end
