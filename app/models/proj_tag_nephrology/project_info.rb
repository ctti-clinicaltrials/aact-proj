module ProjTagNephrology
  class ProjectInfo

    def self.meta_info
      #  Required:  name, schema_name & migration_file_name
      { name:                 'Tag MeSH Terms Related to Nephrology',
        schema_name:          'proj_tag_nephrology',
        brief_summary:        "In conducting a systematic review of nephrology-related studies in ClinicalTrials.gov, the investigators tagged nephrology-related MeSH terms.",
        migration_file_name:  Rails.root.join('db','migrate',' 20181104000122_create_proj_tag_nephrology_tables.rb').to_s,
        organizations:        'Duke Clinical Research Institute',
        data_available:       true,
        start_date:           Date.strptime('27/09/2010', '%d/%m/%Y'),
        year:                 2014,
      }
    end

    def self.publications
      [{
        journal_name:     'American Journal of Kidney Diseases : the Official Journal of the National Kidney Foundation',
        publication_date: Date.strptime('05/01/2014', '%d/%m/%Y'),
        pub_type:         'AcademicArticle',
        title:            'The landscape of clinical trials in nephrology: a systematic review of Clinicaltrials.gov.',
        url:              'https://www.ncbi.nlm.nih.gov/pubmed/24315119',
        citation:         'Inrig, JK; Califf, RM; Tasneem, A; Vegunta, RK; Molina, C; Stanifer, JW; Chiswell, K; Patel, UD'
      }]
    end

    def self.datasets
      [
        {
          dataset_type: 'tags',
          schema_name:  'proj_tag_nephrology',
          table_name:   'tagged_terms',
          name:         'Tagged Nephrology Terms',
          file_name:    "#{Rails.public_path}/incoming/2010_nephrology_mesh_tagged_terms.xlsx",
          file_type:    'application/vnd.openxmlformats-officedocument.spreads'
        }
      ]
    end

    def self.attachments
      [
        {
          description: '2010 Free Text Terms Tagged by Clinical Domain',
          file_name: "#{Rails.public_path}/incoming/2010_nephrology_free_tagged_terms.xlsx",
          file_type: 'application/vnd.openxmlformats-officedocument.spreads'
        },
        {
          description: '2010 MeSH Terms Tagged by Clinical Domain',
          file_name: "#{Rails.public_path}/incoming/2010_nephrology_mesh_tagged_terms.xlsx",
          file_type: 'application/vnd.openxmlformats-officedocument.spreads'
        },
     ]
    end

    def self.load_project_tables
      ProjTagNephrology::TaggedTerm.populate
    end

  end
end
