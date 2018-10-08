module ProjAnderson
  class ProjectInfo

    def self.meta_info
      #  Required:  name, schema_name & migration_file_name
      { name:                'Compliance with Results Reporting at ClinicalTrials.gov',
        schema_name:         'proj_anderson',
        migration_file_name:  Rails.root.join('db','migrate','20180918000122_create_proj_anderson_tables.rb').to_s,
        investigators:       'Monique L. Anderson, M.D., Karen Chiswell, Ph.D., Eric D. Peterson, M.D., M.P.H., Asba Tasneem, Ph.D., James Topping, M.S., and Robert M. Califf, M.D.',
        organizations: 'Duke Clinical Research Institute',
        start_date: Date.strptime('27/09/2013', '%d/%m/%Y'),
        year: 2013,
        url: 'https://www.nejm.org/doi/full/10.1056/NEJMsa1409364',
        email: 'monique.starks@duke.edu',
        description: 'From all the trials at ClinicalTrials.gov, we identified 13,327 HLACTs that were terminated or completed from January 1, 2008, through August 31, 2012. Of these trials, 77.4% were classified as drug trials. A total of 36.9% of the trials were phase 2 studies, and 23.4% were phase 3 studies; 65.6% were funded by industry. Only 13.4% of trials reported summary results within 12 months after trial completion, whereas 38.3% reported results at any time up to September 27, 2013. Timely reporting was independently associated with factors such as FDA oversight, a later trial phase, and industry funding. A sample review suggested that 45% of industry-funded trials were not required to report results, as compared with 6% of trials funded by the National Institutes of Health (NIH) and 9% of trials that were funded by other government or academic institutions.',
        study_selection_criteria: "Using an algorithm based on input from the National Library of Medicine, we identified trials that were likely to be subject to FDAAA provisions (highly likely applicable clinical trials, or HLACTs) from 2008 through 2013. We determined the proportion of HLACTs that reported results within the 12-month interval mandated by the FDAAA or at any time during the 5-year study period. We used regression models to examine characteristics associated with reporting at 12 months and throughout the 5-year study period."
      }
    end

    def self.publications
      [
        {
          published_in: 'NEJM',
          published_on: Date.strptime('12/03/2015', '%d/%m/%Y'),
          url:          'https://www.nejm.org/doi/full/10.1056/NEJMsa1409364?query=featured_home'
        }
      ]
    end

    def self.datasets
      [
        {
          dataset_type: 'results',
          schema_name:  'proj_anderson',
          table_name:   'analyzed_studies',
          name:         'analyzed studies'
        }
      ]
    end

    def self.attachments
      [
        {
          file_name: "#{Rails.public_path}/attachments/proj_anderson.xlsx",
          file_type: 'application/vnd.openxmlformats-officedocument.spreads'
        }
      ]
    end

    def self.load_project_tables
      ProjAnderson::AnalyzedStudy.populate
    end

  end
end
