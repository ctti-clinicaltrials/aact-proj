module ProjTagMoc
  class AnalyzedStudy < ActiveRecord::Base
    self.table_name = 'proj_tag_moc.analyzed_studies'

    def self.populate
      file_name = ProjTagMoc::ProjectInfo.datasets.select{|ds| ds[:table_name] == 'analyzed_studies'}.first[:file_name]
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
                  :nct_id                   => row['nct_id'],
                  :overall_status           => row['overall_status'],
                  :phase                    => row['phase'],
                  :url                      => row['url'],
                  :brief_title              => row['brief_title'],
                  :start_date               => row['start_date'],
                  :start_date_type          => row['start_date_type'],
                  :primary_completion_date  => row['primary_completion_date'],
                  :primary_completion_date_type        => row['primary_completion_date_type'],
                  :acronym                  => row['acronym'],
                  :source                   => row['source'],
                  :number_of_arms           => row['number_of_arms'],
                  :sponsors                 => row['sponsors'],
                  :group_types              => row['group_types'],
                  :enrollment               => row['enrollment'],
                  :enrollment_type          => row['enrollment_type'],
                  :has_dmc                  => row['has_dmc'],
                  :healthy_volunteers       => row['healthy_volunteers'],
                  :gender                   => row['gender'],
                  :gender_based             => row['gender_based'],
                  :keywords                 => row['keywords'],
                  :interventions            => row['interventions'],
                  :baseline_population      => row['why_stopped'],
                  :limitations_and_caveats  => row['limitations_and_caveats'],
                  :actual_duration          => row['actual_duration'],
                  :were_results_reported    => row['were_results_reported'],
                  :months_to_report_results => row['months_to_report_results'],
                  :has_us_facility          => row['has_us_facility'],
                  :number_of_facilities     => row['number_of_facilities'],
                  :facilities               => row['facilities'],
                  :states                   => row['states'],
                  :countries                => row['countries'],
                  :minimum_age_num          => row['minimum_age_num'],
                  :minimum_age_unit         => row['minimum_age_unit'],
                  :maximum_age_num          => row['maximum_age_num'],
                  :maximum_age_unit         => row['maximum_age_unit'],
                  :allocation               => row['allocation'],
                  :intervention_model       => row['intervention_model'],
                  :intervention_types       => row['intervention_types'],
                  :primary_purpose          => row['primary_purpose'],
                  :masking                  => row['masking'],
                ).save!
        end
      }
    end

  end
end
