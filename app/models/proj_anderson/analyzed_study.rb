module ProjAnderson
  class AnalyzedStudy < ActiveRecord::Base
    self.table_name = 'proj_anderson.analyzed_studies'

    def self.populate
      file_name="#{Rails.public_path}/attachments/proj_anderson.xlsx"
      self.populate_from_file(file_name)
    end

    def self.populate_from_file(file_name)
      connection.execute("TRUNCATE TABLE #{table_name};")
      data = Roo::Spreadsheet.open(file_name).sheet("Analysis Data")
      header = data.first.map(&:downcase)

      (2..data.last_row).each  {|i|
        row = Hash[[header, data.row(i)].transpose]
        if !row['nct_id'].blank?
                create(
                  :nct_id                   => row['nct_id'],
                  :url                      => row['url'],
                  :brief_title              => row['brief_title'],
                  :start_month              => row['start_month'],
                  :start_year               => row['start_year'],
                  :p_completion_month       => row['p_completion_month'],
                  :p_completion_year        => row['p_completion_year'],
                  :completion_month         => row['completion_month'],
                  :completion_year          => row['completion_year'],
                  :verification_month       => row['verification_month'],
                  :verification_year        => row['verification_year'],
                  :p_comp_mn                => row['p_comp_mn'],
                  :p_comp_yr                => row['p_comp_yr'],
                  :received_year            => row['received_year'],
                  :mntopcom                 => row['mntopcom'],
                  :enrollment               => row['enrollment'],
                  :number_of_arms           => row['number_of_arms'],
                  :allocation               => row['allocation'],
                  :masking                  => row['masking'],
                  :phase                    => row['phase'],
                  :primary_purpose          => row['primary_purpose'],
                  :sponsor_name             => row['sponsor_name'],
                  :agency_class             => row['agency_class'],
                  :collaborator_names       => row['collaborator_names'],
                  :funding                  => row['funding'],
                  :responsible_party_type   => row['responsible_party_type'],
                  :responsible_party_organization   => row['responsible_party_organization'],
                  :us_coderc                => row['us_coderc'],
                  :oversight                => row['oversight'],
                  :behavioral               => row['behavioral'],
                  :biological               => row['biological'],
                  :device                   => row['device'],
                  :dietsup                  => row['dietsup'],
                  :drug                     => row['drug'],
                  :genetic                  => row['genetic'],
                  :procedure                => row['procedure'],
                  :radiation                => row['radiation'],
                  :otherint                 => row['otherint'],
                  :intervg1                 => row['intervg1'],
                  :results                  => row['results'],
                  :resultsreceived_month    => row['resultsreceived_month'],
                  :resultsreceived_year     => row['resultsreceived_year'],
                  :firstreceived_results_dt => row['firstreceived_results_dt'],
                  :t2result                 => row['t2result'],
                  :t2result_imp             => row['t2result_imp'],
                  :t2resmod                 => row['t2mod'],
                  :results12                => row['results12'],
                  :delayed                  => row['delayed'],
                  :dr_received_dt           => row['dr_received_dt'],
                  :mn2delay                 => row['mn2delay'],
                  :delayed12                => row['delayed12'],
                ).save!
        end
      }
    end

  end
end
