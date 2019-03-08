module ProjTagCardiology
  class ProjectInfo

    def self.meta_info
      { name:                 '',
        schema_name:          'proj_tag_cardiology',
        brief_summary:        "",
        investigators:        '',
        migration_file_name:  Rails.root.join('db','migrate','20190306000122_create_proj_tag_cardiology_tables.rb').to_s,
        organizations:        'Duke Clinical Research Institute',
        data_available:       true,
        aact_version:         'September 27, 2010',
        start_date:           Date.strptime('27/09/2010', '%d/%m/%Y'),
        year:                 2013,
        study_selection_criteria: ''
      }
    end

    def self.publications
      [{
        journal_name:     '',
        publication_date: Date.strptime('05/01/2014', '%d/%m/%Y'),
        pub_type:         'AcademicArticle',
        title:            '',
        url:              'https://www.ncbi.nlm.nih.gov/pubmed/',
        pmid:             '',
        pmcid:            '',
        doi:              '',
        citation:         ''
      }]
    end

    def self.datasets
      [
        {
          dataset_type: 'terms',
          schema_name:  'proj_tag_cardiology',
          table_name:   'tagged_terms',
          name:         'Cardiology Terms (MeSH & Free Text)',
          file_name:    "#{Rails.public_path}/attachments/proj_tag_cardiology_terms.xlsx",
          file_type:    'application/vnd.openxmlformats-officedocument.spreads',
          description:  '582 unique MeSH condition terms & 45 unique free text condition terms tagged for pulmonary',
          source:       'The MeSH terms are from the 2010 MeSH thesaurus, terms in branches C, E, F, G. The free text terms are those  that occurred in AACT(2010).Conditions field with frequency >=5 among interventional studies registered on or after Oct 1, 2007, and that did not exist in MeSH thesaurus.'
        },
        {
          dataset_type: 'study list',
          schema_name:  'proj_tag_cardiology',
          table_name:   'analyzed_studies',
          name:         'Analyzed Studies',
          file_name:    "#{Rails.public_path}/attachments/proj_tag_cardiology_studies.xlsx",
          file_type:    'application/vnd.openxmlformats-officedocument.spreads',
          source:       "From AACT(2010), subset on 40,970 interventional studies registered on or after October 1, 2007. Searched for studies with nephrology-specific terms in AACT(2010).Conditions, OR AACT(2010).Keywords, OR AACT(2010).MeSH_Trees (where MeSH_Type='condition). Investigators then reviewed the resulting list of studies and identified the final cohort of 1054 nephrology trials reported in the manuscript."
        },
      ]
    end

    def self.attachments
      []
    end

    def self.load_project_tables
    end

  end
end
