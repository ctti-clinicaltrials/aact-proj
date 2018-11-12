module Util
  class Updater

    def self.run
      Admin::Project.project_list.each{ |proj_module| new.populate("Proj#{proj_module}") }
      Util::DbManager.new.refresh_public_db
    end

    def populate(proj_module)
      puts "Populating #{proj_module}..."
      proj_info = "#{proj_module}::ProjectInfo".constantize
      new_proj = Admin::Project.new( proj_info.meta_info )
      Admin::Project.where('name=?',proj_info.name).each{ |p| p.destroy }
      proj_info.attachments.each{ |a| new_proj.attachments << Admin::Attachment.create_from(a) }
      proj_info.publications.each{ |p| new_proj.publications << Admin::Publication.create(p) }
      proj_info.datasets.each{ |ds|
        file = Rack::Test::UploadedFile.new(ds[:file_name], ds[:file_type])
        new_proj.datasets << Admin::Dataset.create_from(ds, file)
      }
      new_proj.save!
      #DataDefinition.populate(new_proj.schema_name)
      proj_info.load_project_tables
    end

    def image
      attachments.select{|a| a.is_image }.first
    end

    def data_def_attachment
      # There could be multiple attachments defined as Data Definitions. For now, just return first one.
      attachments.select{|a| a.description == 'Data Definitions' }.first
    end

    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |uc|
          csv << uc.attributes.values_at(*column_names)
        end
      end
    end

  end
end
