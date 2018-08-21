# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
proj = UseCase.create(
            name: 'Clinically Categorize - Cardiology',
            investigators: 'Karen Alexander, David Kong',
            organizations: 'Duke Clinical Research Institute',
            start_date: Date.strptime('27/09/2011', '%d/%m/%Y'),
            year: 2011,
            study_selection_criteria: "see methods section of publication: 'http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0033677",
            description: "We developed and validated a methodology for annotating studies by clinical specialty, using a custom taxonomy employing Medical Subject Heading (MeSH) terms applied by an NLM algorithm, as well as MeSH terms and other disease condition terms provided by study sponsors. Clinical specialists reviewed and annotated MeSH and non-MeSH disease condition terms, and an algorithm was created to classify studies into clinical specialties based on both MeSH and non-MeSH annotations. False positives and false negatives were evaluated by comparing algorithmic classification with manual classification for three specialties.")

Publication.create(project: proj, url: 'http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0033677')
Dataset.create(project: proj, dataset_type: 'support', name: 'y2010_mesh_term', description: '2010 MeSH Thesauraus')
Dataset.create(project: proj, dataset_type: 'results',  name: 'analyzed_free_text_terms', description: 'Free text terms (as opposed to MeSH terms) from ClinicalTrials.gov conditions that were analyzed by clinicians and assigned to one or more of 24 clinical categories.  Each row represent a free text term and each column represents a clinical category.')
Dataset.create(project: proj, dataset_type: 'results',  name: 'analyzed_mesh_terms', description: 'MeSH terms from ClinicalTrials.gov conditions that were analyzed by clinicians and assigned to one or more of 24 clinical categories.  Each row represent a free text term and each column represents a clinical category.')
Dataset.create(project: proj, dataset_type: 'summary',  name: 'categorized_terms', description: 'Table containing a list of all terms (MeSH & free) and the clinical category to which it has been assigned.  A row exists for each clinical category to which a term has been assigned, so there may be multiple rows in the table for the same term.')


proj = UseCase.create(
            name: 'Clinically Categorize - Oncology',
            investigators: 'Amy Abernathy, Brad Hirsch',
            organizations: 'Duke Clinical Research Institute',
            start_date: Date.strptime('27/09/2011', '%d/%m/%Y'),
            year: 2011,
            description: "We developed and validated a methodology for annotating studies by clinical specialty, using a custom taxonomy employing Medical Subject Heading (MeSH) terms applied by an NLM algorithm, as well as MeSH terms and other disease condition terms provided by study sponsors. Clinical specialists reviewed and annotated MeSH and non-MeSH disease condition terms, and an algorithm was created to classify studies into clinical specialties based on both MeSH and non-MeSH annotations. False positives and false negatives were evaluated by comparing algorithmic classification with manual classification for three specialties.",
            protocol: "The xx sections of the 2010 MeSH thesaurus was reviewed by a set of clinicians...",
            issues:  "100 conflicting MeSH id tags.Faculty decided to review ambiguous studies as opposed to adjudicating MeSH tags.  Same tags used as those in Rob Califf's manuscript."
   )
Publication.create(project: proj, url: 'http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0033677')

