module ProjClinwiki
  class ProjectInfo

    def self.meta_info
      #  Required:  name & schema_name
      #  If migration_file_name defined, add code that will populate it to the method: load_project_tables
      { name:                'Clinwiki - Crowd-Source Website to Categorize & Annotate Clinical Trials (beta)',
        schema_name:         'proj_clinwiki',
        investigators:       'Willy Hoos',
        organizations:       'Clinwiki',
        data_available:      false,
        start_date:          Date.strptime('07/01/2018', '%d/%m/%Y'),
        year:                2018,
        email:               'william.hoos@gmail.com',
        url:                 'https://clinwiki-prod.herokuapp.com/search/CancerCommonsGBM',
        brief_summary:       'Crowd-source website that enhances ClinicalTrials.gov data by allowing the public to annotate and rate trials.',
        description: "Clinwiki is a platform that will provide the public with tools to annotate clinical trials, flag missing or incorrect data elements, enter lay summaries and rate clinical trials on a number of dimensions including: Ease of participation Potential for breakthrough efficacy Side effect risk Quality of design Overall risk/reward Contributing users will be categorized into types: Verified Physician Specialist Medical Professional Scientist General User Within this, users will be ranked based on social metrics - #ratings/comments, upvotes of comments, etc. The website dynamically queries and retrieves clinical trials data from AACT and then saves user-entered values to a separate database administered by Clinwiki staff. Clinwiki is currently under development. A preliminary version is available at the link provided."
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
        description: 'Sample image',
        file_name: "#{Rails.public_path}/attachments/clinwiki-image.png",
        file_type: 'image/png'
      ]
    end

    def self.load_project_tables
    end

  end
end
