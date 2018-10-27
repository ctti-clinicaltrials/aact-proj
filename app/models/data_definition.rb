require 'active_support/all'
class DataDefinition < ActiveRecord::Base

  def self.populate(schema_name, data)
    header = data.first
    dataOut = []
    (2..data.last_row).each do |i|
      row = Hash[[header, data.row(i)].transpose]
      if !row['table'].nil? and !row['column'].nil?
        new(:schema_name   => schema_name,
            :table_name    =>row['table'].try(:downcase),
            :column_name   =>row['column'].try(:downcase),
            :category      =>row['category'],
            :label         =>row['label'],
            :data_type     =>row['data type'].try(:downcase),
            :source        =>row['source'].try(:downcase),
            :description   =>row['description'],
            :nlm_link      =>row['nlm doc'],
           ).save!
      end
    end
  end

end
