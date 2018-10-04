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

# 2015 Monique Anderson.  Compliance with Results Reporting at ClinicalTrials.gov
puts  "2015 Monique Anderson......"

projAnderson = Project.new(
            name: 'Compliance with Results Reporting at ClinicalTrials.gov',
            schema_name: 'proj_anderson',
            investigators: 'Monique L. Anderson, M.D., Karen Chiswell, Ph.D., Eric D. Peterson, M.D., M.P.H., Asba Tasneem, Ph.D., James Topping, M.S., and Robert M. Califf, M.D.',
            organizations: 'Duke Clinical Research Institute',
            start_date: Date.strptime('27/09/2013', '%d/%m/%Y'),
            year: 2013,
            email: 'monique.starks@duke.edu',
            study_selection_criteria: "Using an algorithm based on input from the National Library of Medicine, we identified trials that were likely to be subject to FDAAA provisions (highly likely applicable clinical trials, or HLACTs) from 2008 through 2013. We determined the proportion of HLACTs that reported results within the 12-month interval mandated by the FDAAA or at any time during the 5-year study period. We used regression models to examine characteristics associated with reporting at 12 months and throughout the 5-year study period.")

projAnderson.publications << Publication.create(
     published_in: 'NEJM',
     published_on: Date.strptime('12/03/2015', '%d/%m/%Y'),
     url: 'https://www.nejm.org/doi/full/10.1056/NEJMsa1409364?query=featured_home')

projAnderson.datasets << Dataset.create(
     dataset_type: 'results',
     schema_name: 'proj_anderson',
     table_name: 'analyzed_studies',
     name: 'analyzed studies')

file_name="#{Rails.public_path}/attachments/proj_anderson.xlsx"
file = Rack::Test::UploadedFile.new(file_name, 'application/vnd.openxmlformats-officedocument.spreads')
projAnderson.attachments << Attachment.create_from(file)
projAnderson.save!
ProjAnderson::AnalyzedStudy.populate

puts "Created #{Project.count} use cases."
