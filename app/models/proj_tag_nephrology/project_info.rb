module ProjTagNephrology
  class ProjectInfo

    def self.meta_info
      #  Required:  name, schema_name & migration_file_name
      { name:                 'The Landscape of Clinical Trials in Nephrology: A Systematic Review of ClinicalTrials.gov',
        schema_name:          'proj_tag_nephrology',
        brief_summary:        "While conducting a systematic review of nephrology-related studies in ClinicalTrials.gov, the investigators tagged nephrology-related MeSH & free-text terms. Interventional studies registered between Oct 1, 2007 & September 27, 2010 with conditions, browse_conditions or keywords that matched any of the terms tagged as 'nephrology' were included in the analysis.",
        investigators:        'Jula K. Inrig, MD,1,2 Robert M. Califf, MD,1 Asba Tasneem, PhD,1 Radha K. Vegunta, MD,3 Christopher Molina, BS,4 John W. Stanifer, MD,1 Karen Chiswell, PhD,1 and Uptal D. Patel, MD1',
        migration_file_name:  Rails.root.join('db','migrate','20181104000122_create_proj_tag_nephrology_tables.rb').to_s,
        organizations:        'Duke Clinical Research Institute',
        data_available:       true,
        aact_version:         '9/27/10',
        start_date:           Date.strptime('27/09/2010', '%d/%m/%Y'),
        year:                 2014,
        study_selection_criteria: 'The nephrology data set was restricted to interventional study types registered in the larger data set between October 1, 2007, and September 27, 2010 (n 5 40,970 of 94,346; Fig 1). Noninterventional studies (such as observational or cohort studies) were eliminated to minimize bias related to the lack of reporting requirements for these studies. The data set was created by using disease-specific condition terms (both Medical Subject Headings [MeSH] and non-MeSH) that were provided by the data sub- mitters, and additional MeSH terms that were generated by a National Library of Medicine algorithm. Investigators at Duke reviewed 18,491 records from the MeSH dictionary, and terms were annotated according to their relevance to nephrology. MeSH terms with conflicting tags (ie, multiple records in the dictionary) were adjudicated by the investigators. Of the 9,031 unique MeSH terms individually adjudicated, 83 were tagged to be nephrology- specific (Item S1, available as online supplementary material). Also, investigators reviewed 1,220 unique, common, free-text terms and identified 31 nephrology-specific terms.
An initial data set of 998 studies was identified as having conditions relevant to nephrology. Another 80 studies (identified by additional key words and free text) were added. In total, 1,078 studies were individually reviewed by 2 nephrologists (brief title, key words, conditions, MeSH terms, and if necessary, the full ClinicalTrials.gov record) to determine relevance to nephrology. In total, 24 studies were excluded as irrelevant to nephrology, leaving a final data set of 1,054 studies. Similar methods were used to identify 2,325 cardiology studies17; 61 studies that also were in the nephrology group were excluded, resulting in a subset of 2,264 cardiology studies used for comparison in this analysis. The remaining group of “other” studies (n 5 37,652) includes those not classified as nephrology or cardiology.',
       description: 'A systematic review of interventional (ie, nonobservational) studies (both randomized and nonrandomized) registered between October 2007 and September 2010 were included for analysis. Studies were reviewed independently by physicians and classified by clinical specialty.'
      }
    end

    def self.publications
      [{
        journal_name:     'American Journal of Kidney Diseases : the Official Journal of the National Kidney Foundation',
        publication_date: Date.strptime('05/01/2014', '%d/%m/%Y'),
        pub_type:         'AcademicArticle',
        title:            'The landscape of clinical trials in nephrology: a systematic review of Clinicaltrials.gov.',
        url:              'https://www.ncbi.nlm.nih.gov/pubmed/24315119',
        pmid:             '24315119',
        pmcid:            'PMC3988265',
        doi:              '10.1053/j.ajkd.2013.10.043',
        citation:         'Inrig JK, Califf RM, Tasneem A, Vegunta RK, Molina C, Stanifer JW, Chiswell K, Patel UD. The landscape of clinical trials in nephrology: a systematic review of Clinicaltrials. gov. American Journal of Kidney Diseases. 2014 May 1;63(5):771-80.'
      }]
    end

    def self.datasets
      [
        {
          dataset_type: 'terms',
          schema_name:  'proj_tag_nephrology',
          table_name:   'tagged_terms',
          name:         'Nephrology Terms (MeSH & Free Text)',
          file_name:    "#{Rails.public_path}/attachments/proj_tag_nephrology_terms.xlsx",
          file_type:    'application/vnd.openxmlformats-officedocument.spreads',
          description:  '83 unique MeSH condition terms & 31 unique free text condition terms tagged for nephrology',
          source:       'The MeSH terms are from the 2010 MeSH thesaurus, terms in branches C, E, F, G. The free text terms are those  that occurred in AACT(2010).Conditions field with frequency >=5 among interventional studies registered on or after Oct 1, 2007, and that did not exist in MeSH thesaurus.'
        },
        {
          dataset_type: 'study list',
          schema_name:  'proj_tag_nephrology',
          table_name:   'analyzed_studies',
          name:         'Analyzed Studies',
          file_name:    "#{Rails.public_path}/attachments/proj_tag_nephrology_studies.xlsx",
          file_type:    'application/vnd.openxmlformats-officedocument.spreads',
          source:       "From AACT(2010), subset on 40,970 interventional studies registered on or after October 1, 2007. Searched for studies with nephrology-specific terms in AACT(2010).Conditions, OR AACT(2010).Keywords, OR AACT(2010).MeSH_Trees (where MeSH_Type='condition)"
        },
      ]
    end

    def self.attachments
      []
    end

    def self.load_project_tables
      ProjTagNephrology::TaggedTerm.populate
      ProjTagNephrology::AnalyzedStudy.populate
    end

  end
end
