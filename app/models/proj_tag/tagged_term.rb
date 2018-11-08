module ProjTag
  class TaggedTerm < ActiveRecord::Base
    self.table_name = 'proj_tag.tagged_terms'

    def self.populate
      # Put a spreadsheet in the public/incoming directory.
      # Spreadsheet name should be YYYY_<type>_tagged_terms.xlsx  (where YYYY is the year & <type> is something like 'mesh' or 'free')
      # Spreadsheet should have one sheet with a 'term' column and optionally an identifier column.
      # The remaining column headers will be considered 'tags'.
      # If an x or y (or X or Y) is found in the column, the term will be tagged with the column header.
      # For example the first 2 rows of an incoming spreadsheet:
      #
      #   identifier        term                    pulmonary   transplant
      #   C01.252.100.375   hemorrhagic septicemia  Y           N

      dir="#{Rails.public_path}/incoming"
      file_names=Dir.entries(dir).select{|fn|
        # collect the mesh term files
        # eliminate those preceded with ~ char which represents open file
        (fn.include? 'tagged_terms.xlsx') and fn[0] != '~'
      }
      puts ">>>>>> Importing tagged terms from #{file_names.size} files."
      file_names.each{|file_name|
        self.populate_from_file("#{dir}/#{file_name}")
      }
    end

    def self.populate_from_file(file_name)
      data = Roo::Spreadsheet.open(file_name)
      fn = file_name.split('/').last.split('_')
      year = fn[0]
      term_type = fn[1]
      header = data.first.map(&:downcase)
      puts "  >>>> #{data.last_row} tagged #{term_type} terms for #{year} from #{fn}"

      (2..data.last_row).each  {|i|
        row = Hash[[header, data.row(i)].transpose]
        if !row['term'].blank?
          tags= row.map{|key,value| key if ['y','x'].include? value.try(:downcase) }.reject(&:blank?)
          if !tags.empty?
            tags.each{ |tag|
                create(
                  :identifier   => row['identifier'],
                  :tag          => tag,
                  :term         => row['term'].downcase,
                  :year         => year,
                  :term_type    => term_type,
                ).save!
            }
          end
        end
      }
    end

  end
end
