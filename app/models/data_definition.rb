require 'active_support/all'
class DataDefinition < ActiveRecord::Base
  #belongs_to :project, :foreign_key=> 'schema_name'

  def self.populate(schema_name)
    # If Data Defs exist for the project, they will have been loaded as an attachment with description 'Data Definitions'
    file = DataDefinition.data_def_file_for(schema_name)
    return if file.nil?
    data = file.sheet_for('Data Definitions')
    return if data.nil?

    header = data.row(1)
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

  def self.data_def_file_for(schema_name)
    #  Assumes any attachment described as 'Data Definitions' will have a sheet also named 'Data Definitions'
    #  and that sheet can be used to populate the Data_Definitions table. (ie. it contains columns that match
    #  columns in proj.data_definitions table.
    defs = self.where('schema_name = ? and description = ?', schema_name, 'Data Definitions')
    return nil if defs.empty?
    # Suppose there can be multiple attachments per project defined as Data Definitions. For now, just use the first one.
    file_name = defs.first.original_file_name
    return Roo::Spreadsheet.open(file_name)
  end

end
