module ProjStandardOrgs
  class ProjectInfo

    def self.meta_info
      #  Required:  name, schema_name & migration_file_name
      { name:                 'Standardize Organization Names',
        schema_name:          'proj_standard_orgs',
        brief_summary:        'The CDEK project at Washington University has curated organization data to standardize terminology.',
        investigators:        'Rebekah Griesenauer, PhD, Postdoctoral Scholar; Michael S Kinch, PhD, Associate Vice Chancellor',
        migration_file_name:  Rails.root.join('db','migrate','20181108000122_create_proj_standard_orgs_tables.rb').to_s,
        organizations:        'Washington University - St. Louis. Center for Research Innovation and Biotechnology',
        data_available:       true,
        start_date:           Date.strptime('27/09/2010', '%d/%m/%Y'),
        year:                 2018,
        study_selection_criteria: '',
        description:         ''
      }
    end

    def self.publications
      []
    end

    def self.datasets
      [
        {
          dataset_type: 'terms',
          schema_name:  'proj_standard_orgs',
          table_name:   'organizations',
          name:         'Standardized Organization Names',
          file_name:    "#{Rails.public_path}/attachments/proj_standard_orgs_organizations.xlsx",
          file_type:    'application/vnd.openxmlformats-officedocument.spreads'
        },
        {
          dataset_type: 'links',
          schema_name:  'proj_standard_orgs',
          table_name:   'synonyms',
          name:         'Synonyms',
          file_name:    "#{Rails.public_path}/attachments/proj_standard_orgs_synonyms.xlsx",
          file_type: 'application/vnd.openxmlformats-officedocument.spreads'
        },
      ]
    end

    def self.attachments
      []
    end

    def self.load_project_tables
      ProjStandardOrgs::Organization.populate
      ProjStandardOrgs::Synonym.populate
    end

  end
end
