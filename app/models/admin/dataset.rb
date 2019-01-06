module Admin
  class Dataset < AdminBase
    belongs_to :project

    def self.create_from(ds, file)
      new({:file_name     => sanitize_filename(file.original_filename),
           :content_type  => file.content_type,
           :file_contents => file.read,
           :dataset_type  => ds[:dataset_type],
           :schema_name   => ds[:schema_name],
           :table_name    => ds[:table_name],
           :name          => ds[:name],
           :description   => ds[:description],
           :source        => ds[:source],
           :made_available_on   => ds[:made_available_on],
          })
    end

    def renderable
      Base64.encode64(file_contents)
    end

    def self.sanitize_filename(file_name)
      return File.basename(file_name)
    end

  end
end
