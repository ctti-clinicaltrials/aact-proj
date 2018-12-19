module ProjEeg
  class ProjectInfo

    def self.meta_info
      #  Required:  name & schema_name
      #  If migration_file_name defined, add code that will populate it to the method: load_project_tables
      { name:                'EEG-related Trials.  Geographic Distribution',
        schema_name:         'proj_eeg',
        investigators:       'Sheri Tibbs',
        organizations:       'DCRI',
        data_available:      false,
        start_date:          Date.strptime('05/01/2016', '%d/%m/%Y'),
        year:                2016,
        email:               'sheri.tibbs@duke.edu',
        url:                 'https://eeg-studies.herokuapp.com/index.html',
        brief_summary:       'Static website providing statistics & visualizations about the distribution of EEG-related clinical trials conducted through 2016.',
        description:         "The informatics team and business development at Duke Clinical Research Institute asked us to identify locations where EEG-related clinical trials are and have been conducted, and which of these studies are currently recruiting. We downloaded the most recent version of AACT and created a search function to return the NCT ID for studies where keywords, interventions or titles included the term 'EEG', 'Electroencephalogram' or 'Electroencephalography'. We used those IDs to generate a view of clinical trial information and referred a Tableau workbook to this view by defining it as the data source. The Tableau workbook attached here provides some of the graphics developed. (You will need to connect to the AACT database through a PostgreSQL connection using the credentials found at the bottom of the AACT website's Connect page. (Note, this use case was initially created in Spring, 2016 to serve as a proof of concept and help us design/develop AACT. The url provided is a link to a website that presents a preliminary version of the visualizations that were first created in May, 2016.)"
      }
    end

    def self.publications
      []
    end

    def self.datasets
      []
    end

    def self.attachments
      [
        description: 'Sample image showing where EEG-related studies are being (and have been) conducted.',
        file_name: "#{Rails.public_path}/attachments/eeg-related-trials.png",
        file_type: 'image/png'
      ]
    end

    def self.load_project_tables
    end

  end
end
