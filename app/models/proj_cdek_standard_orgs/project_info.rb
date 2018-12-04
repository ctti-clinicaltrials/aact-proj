module ProjCdekStandardOrgs
  class ProjectInfo

    def self.meta_info
      #  Required:  name, schema_name & migration_file_name

    {
     name:           'CDEK’s Standard Organization Names',
     schema_name:    'proj_cdek_standard_orgs',
     migration_file_name:  Rails.root.join('db','migrate','20181108000122_create_proj_cdek_standard_orgs_tables.rb').to_s,
     brief_summary:  'The CDEK project at Washington University has curated organization data to standardize terminology.',
     investigators:  'Rebekah Griesenauer, PhD, Postdoctoral Scholar; Michael S Kinch, PhD, Associate Vice Chancellor',
     organizations:  'Washington University - St. Louis. Center for Research Innovation and Biotechnology',
     data_available: true,
     start_date:     Date.strptime('27/09/2016', '%d/%m/%Y'),
     year:           2018,
     description:   ' Clinical Drug Experience Knowledgebase (CDEK) is a database and web-platform to enable researchers and analysts to study all active pharmaceutical ingredients with evidence of clinical experience in humans. CDEK contains over 20,000 active pharmaceutical ingredients with surrounding annotated metadata (i.e. sponsoring organizations, indications, clinical trial data, chemical structure, etc). We curated CDEK in part by disambiguating intervention and organization names from ClinicalTrials.gov (through AACT). This information was cross-referenced against entries in prominent international drug databases (e.g. PubChem, ChEMBL, DrugBank). We have a prototype web-application designed to allow researchers of all backgrounds to access and query the data (cdek.wustl.edu).'
     }
    end

    def self.publications
      []
    end

    def self.datasets
      [
        {
          dataset_type: 'terms',
          schema_name:  'proj_cdek_standard_orgs',
          table_name:   'organizations',
          name:         'CDEK Standardized Organization Names',
          file_name:    "#{Rails.public_path}/attachments/proj_cdek_standard_orgs_organizations.xlsx",
          file_type:    'application/vnd.openxmlformats-officedocument.spreads'
        },
        {
          dataset_type: 'links',
          schema_name:  'proj_cdek_standard_orgs',
          table_name:   'synonyms',
          name:         'CDEK Organization Synonyms',
          file_name:    "#{Rails.public_path}/attachments/proj_cdek_standard_orgs_synonyms.xlsx",
          file_type: 'application/vnd.openxmlformats-officedocument.spreads'
        },
      ]
    end

    def self.attachments
      []
    end

    def self.load_project_tables
      ProjCdekStandardOrgs::CdekOrganization.populate
      ProjCdekStandardOrgs::CdekSynonym.populate
    end

  end
end
