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
    con=ActiveRecord::Base.establish_connection(ENV['AACT_PROJ_DATABASE_URL']).connection
    con.execute("CREATE OR REPLACE VIEW #{schema_name}.data_definitions AS SELECT * FROM proj.data_definitions WHERE schema_name='#{schema_name}';")
  end

end
