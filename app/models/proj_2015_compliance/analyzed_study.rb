module Proj2015Compliance
  class AnalyzedStudy < ActiveRecord::Base

    def populate
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

  end
end
