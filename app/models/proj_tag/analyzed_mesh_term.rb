module ProjTag
  class AnalyzedMeshTerm < ActiveRecord::Base

    def self.populate
      dir="#{Rails.public_path}/csv"
      file_names=Dir.entries(dir).select{|fn|
        # collect the analyze mesh term files
        # eliminate those preceded with ~ char which represents open file
        (fn.include? 'analyzed_mesh_terms.xlsx') and fn[0] != '~'
      }
      file_names.each{|file_name|
        self.populate_from_file("#{dir}/#{file_name}")
      }
    end

    def self.populate_from_file(file_name)
      puts "=========================== >> #{file_name}"
      data = Roo::Spreadsheet.open(file_name)
      year = file_name.split('/').last.split('_').first
      header = data.first.map(&:downcase)
      puts "  >> #{data.last_row} analyzed mesh terms for #{year}"

      (2..data.last_row).each  {|i|
        row = Hash[[header, data.row(i)].transpose]
        if !row['mesh_id'].blank? and !row['mesh_term'].blank?
          categories= row.map{|key,value| key if ['y','x'].include? value.try(:downcase) }.reject(&:blank?)
          if !categories.empty?
            new(:qualifier     => row['mesh_id'].split('.').first,
                :identifier    => row['mesh_id'],
                :term          => row['mesh_term'],
                :downcase_term => row['mesh_term'].try(:downcase),
            ).save

            categories.each{ |cat|
                ProjTag::CategorizedTerm.create(
                  :project_id   => '1',
                  :identifier   => row['mesh_id'],
                  :category     => cat,
                  :term         => row['mesh_term'].downcase,
                  :year         => year,
                  :term_type    => 'mesh',
                ).save!
            }
          end
        end
      }
    end

  end
end
