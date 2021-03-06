module MeshArchive
  class Y2016MeshHeading < ActiveRecord::Base

    def self.populate_from_file(file_name=Rails.root.join('public','incoming','mesh','2016_mesh_headings.txt'))
      puts "about to populate table of mesh headings..."
      destroy_all
      qualifier=''
      heading=''
      File.open(file_name).each_line{|line|
        if is_heading(line.split(' ').first)
          qualifier=line.split(' ').first
          heading=line[4..line.size]
        else
          new(:qualifier=>qualifier.strip,
              :heading=>heading.strip,
              :subcategory=>line.strip,
             ).save! if line.size > 1
        end
      }
    end

    def self.is_heading(str)
      return false if str.nil?
      return false if str.size != 3
      suffix=str[1..2]
      return false if suffix.to_i.to_s.rjust(2,'0') != suffix  #last 2 chars need to be an integer
      true
    end
  end
end
