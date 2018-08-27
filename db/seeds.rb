# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# Clinwiki
puts  "Clinwiki......"
proj1 = Project.create(
  status: 'public',
  name: 'We are developing a crowd-source platform aimed at publicly highlighting well-designed studies.',
  investigators: 'Willy Hoos',
  organizations: 'Clinwiki',
  description: 'Clinwiki is a platform that will provide the public with tools to annotate clinical trials, flag missing or incorrect data elements, enter lay summaries and rate clinical trials on a number of dimensions including: Ease of participation Potential for breakthrough efficacy Side effect risk Quality of design Overall risk/reward Contributing users will be categorized into types: Verified Physician Specialist Medical Professional Scientist General User Within this, users will be ranked based on social metrics - #ratings/comments, upvotes of comments, etc. The website dynamically queries and retrieves clinical trials data from AACT and then saves user-entered values to a separate database administered by Clinwiki staff. Clinwiki is currently under development. A preliminary version is available at the link provided.',
  url: 'https://clinwiki-prod.herokuapp.com/search/CancerCommonsGBM',
  contact_info: 'http://www.clinwiki.org/',
  submitter_name: 'Willy Hoos',
  email: 'willyhoos@gmail.com',
)
file_name="#{Rails.public_path}/attachments/clinwiki-image.png"
file = Rack::Test::UploadedFile.new(file_name, 'image/png')
proj1.attachments << Attachment.create_from(file)
proj1.save!
puts "Created #{Project.count} use cases."


#  EEG-related Trials
puts  "EEG-related......"
proj2 = Project.create(
  status: 'public',
  name: 'Our goal was to create a map that shows the distribution of EEG-related clinical trials around the world. (As of March, 2017)',
  organizations: 'DCRI',
  description: "The informatics team and business development at Duke Clinical Research Institute asked us to identify locations where EEG-related clinical trials are and have been conducted, and which of these studies are currently recruiting. We downloaded the most recent version of AACT and created a search function to return the NCT ID for studies where keywords, interventions or titles included the term 'EEG', 'Electroencephalogram' or 'Electroencephalography'. We used those IDs to generate a view of clinical trial information and referred a Tableau workbook to this view by defining it as the data source. The Tableau workbook attached here provides some of the graphics developed. (You will need to connect to the AACT database through a PostgreSQL connection using the credentials found at the bottom of the AACT website's Connect page. (Note, this use case was initially created in Spring, 2016 to serve as a proof of concept and help us design/develop AACT. The url provided is a link to a website that presents a preliminary version of the visualizations that were first created in May, 2016.)",
  url: 'https://eeg-studies.herokuapp.com/index.html',
  submitter_name: 'Sheri Tibbs',
  email: 'sheri.tibbs@duke.edu',
)
file_name="#{Rails.public_path}/attachments/eeg-related-trials.png"
file = Rack::Test::UploadedFile.new(file_name, 'image/png')
proj2.attachments << Attachment.create_from(file)
proj2.save!
puts "Created #{Project.count} use cases."

#  Summaries and Trends
puts  "Summary and Trends......"
proj3 = Project.create(
  status: 'public',
  name: 'We were interested in examining how the characteristics of trials registered at ClinicalTrials.gov have changed over time',
  organizations: 'DCRI',
  description: "We accessed the AACT database using SAS(R) v 9.4. Our analysis was restricted to interventional studies registered between 2008-2017. We classified trials according to Funding source (Industry/NIH/Other, derived from sponsor and collaborator fields), Phase, Intervention Type, Site Location (U.S. sites compared to sites in the rest of the world), and appointment of a Data Monitoring Committee. We also examined patterns in months from study start to completion, and in months from study completion to reporting of results at ClinicalTrials.gov in selected subgroups of studies. In this version we examined completeness of a few of the new data elements (e.g., about inclusion of a US FDA regulated drug product). An example graph is displayed in the image file displayed above. The attached Excel file displays additional graphs. To create the Excel file we generated summary numbers from SAS, output them, and created the graphs in Excel. Graphs were also generated directly using SAS procedures and output to a PDF file (see code and output shared via GitHub).",
  url: 'https://github.com/kchis/AACT-Sample-Graphs',
  submitter_name: 'Karen Chiswell',
  contact_info: 'K. Chiswell, Duke Clinical Research Institute',
  email: 'karen.chiswell@duke.edu',
)
file_name1="#{Rails.public_path}/attachments/summaries-and-trends.png"
file_name2="#{Rails.public_path}/attachments/graphs_interventional_trials_January232018.xlsx"
file1 = Rack::Test::UploadedFile.new(file_name1, 'image/png')
file2 = Rack::Test::UploadedFile.new(file_name2, 'application/vnd.openxmlformats-officedocument.spreads')
proj3.attachments << Attachment.create_from(file1)
proj3.attachments << Attachment.create_from(file2)
proj3.save!
puts "Created #{Project.count} use cases."

#   New Test Projects

puts  "Test #1......"
proj4 = Project.new(
            name: 'Clinically Categorize - Cardiology',
            investigators: 'Karen Alexander, David Kong',
            organizations: 'Duke Clinical Research Institute',
            start_date: Date.strptime('27/09/2011', '%d/%m/%Y'),
            year: 2011,
            email: 'sheri.tibbs@duke.edu',
            study_selection_criteria: "see methods section of publication: 'http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0033677",
            description: "We developed and validated a methodology for annotating studies by clinical specialty, using a custom taxonomy employing Medical Subject Heading (MeSH) terms applied by an NLM algorithm, as well as MeSH terms and other disease condition terms provided by study sponsors. Clinical specialists reviewed and annotated MeSH and non-MeSH disease condition terms, and an algorithm was created to classify studies into clinical specialties based on both MeSH and non-MeSH annotations. False positives and false negatives were evaluated by comparing algorithmic classification with manual classification for three specialties.")

proj4.publications << Publication.create(url: 'http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0033677')
proj4.datasets << Dataset.create(dataset_type: 'support', name: 'y2010_mesh_term', description: '2010 MeSH Thesauraus')
proj4.datasets << Dataset.create(dataset_type: 'results',  name: 'analyzed_free_text_terms', description: 'Free text terms (as opposed to MeSH terms) from ClinicalTrials.gov conditions that were analyzed by clinicians and assigned to one or more of 24 clinical categories.  Each row represent a free text term and each column represents a clinical category.')
proj4.datasets << Dataset.create(dataset_type: 'results',  name: 'analyzed_mesh_terms', description: 'MeSH terms from ClinicalTrials.gov conditions that were analyzed by clinicians and assigned to one or more of 24 clinical categories.  Each row represent a free text term and each column represents a clinical category.')
proj4.datasets << Dataset.create(dataset_type: 'summary',  name: 'categorized_terms', description: 'Table containing a list of all terms (MeSH & free) and the clinical category to which it has been assigned.  A row exists for each clinical category to which a term has been assigned, so there may be multiple rows in the table for the same term.')
proj4.save!
puts "Created #{Project.count} use cases."

# other test case
puts  "Test #2......"
proj5 = Project.new(
            name: 'Clinically Categorize - Oncology',
            investigators: 'Amy Abernathy, Brad Hirsch',
            organizations: 'Duke Clinical Research Institute',
            start_date: Date.strptime('27/09/2011', '%d/%m/%Y'),
            year: 2011,
            email: 'sheri.tibbs@duke.edu',
            description: "We developed and validated a methodology for annotating studies by clinical specialty, using a custom taxonomy employing Medical Subject Heading (MeSH) terms applied by an NLM algorithm, as well as MeSH terms and other disease condition terms provided by study sponsors. Clinical specialists reviewed and annotated MeSH and non-MeSH disease condition terms, and an algorithm was created to classify studies into clinical specialties based on both MeSH and non-MeSH annotations. False positives and false negatives were evaluated by comparing algorithmic classification with manual classification for three specialties.",
            protocol: "The xx sections of the 2010 MeSH thesaurus was reviewed by a set of clinicians...",
            issues:  "100 conflicting MeSH id tags.Faculty decided to review ambiguous studies as opposed to adjudicating MeSH tags.  Same tags used as those in Rob Califf's manuscript.")
proj5.publications << Publication.create(url: 'http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0033677')
proj5.save!
puts "Created #{Project.count} use cases."
