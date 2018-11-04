module ProjTagNephrology
  class TaggedNephrologyTerm < ActiveRecord::Base

    self.table_name = 'proj_tag_nephrology.tagged_nephrology_terms'
    def self.populate
      # Put a spreadsheet in the public/incoming directory.
      #
      #   identifier        term                    nephrology
      #   C01.252.100.375   kidney disease              Y

      file="#{Rails.public_path}/incoming/2010_nephrology_mesh_tagged_terms.xlsx"
      self.populate_from_file(file)
      file="#{Rails.public_path}/incoming/2010_nephrology_free_tagged_terms.xlsx"
      self.populate_from_file(file)
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
                  :project_id   => '1',
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
