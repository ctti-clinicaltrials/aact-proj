module ProjTag
  class AnalyzedFreeTextTerm < ActiveRecord::Base

    def self.populate
      # Put a spreadsheet in the public/incoming directory.
      # Spreadsheet should have one sheet with at least 2 columns: identifier & term.
      # The remaining columns will be considered 'tags' - the column header will be the tag name.
      # If an x or y (or X or Y) is found in the column, the term will be tagged with the column header.
      # For example the first 2 rows of an incoming spreadsheet:
      #
      #   identifier        term                    pulmonary   transplant
      #   C01.252.100.375   hemorrhagic septicemia  Y           N

      dir="#{Rails.public_path}/csv/"
      file_names=Dir.entries(dir).select { |fn|
        (fn.include? 'analyzed_free_text_terms.xlsx') and fn[0] != '~'
      }
      file_names.each { |file_name|
        self.populate_from_file("#{dir}/#{file_name}")
      }
    end

    def self.populate_from_file(file_name)
      data = Roo::Spreadsheet.open(file_name)
      year = file_name.split('/').last.split('_').first
      header = data.first.map(&:downcase)
      puts "  >> #{data.last_row} analyzed free text terms for #{year}"

      (2..data.last_row).each { |i|
        row = Hash[[header, data.row(i)].transpose]
        if !row['term'].nil?
          categories= row.map{|key,value| key if ['y','x'].include? value.try(:downcase) }.reject(&:blank?)
          if !categories.empty?
            new(:identifier    => row['term'].downcase,
                :term          => row['term'],
                :downcase_term => row['term'].downcase,
            ).save
          end

          categories.each { |cat|
            ProjTag::CategorizedTerm.create(
              :project_id   => '1',
              :identifier   => row['term'].downcase,
              :category     => cat,
              :term         => row['term'].downcase,
              :year         => year,
              :term_type    => 'free',
            ).save!
          }
        end
      }
    end

  end
end
