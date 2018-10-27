class Attachment < ActiveRecord::Base
  belongs_to :project

  def self.create_from(attachment, image_type=nil)
    file = Rack::Test::UploadedFile.new(attachment[:file_name], attachment[:file_type])
    new({:file_name     => sanitize_filename(file.original_filename),
         :content_type  => file.content_type,
         :file_contents => file.read,
         :is_image      => !image_type.nil?,
         :description   => attachment[:description],
         :original_file_name => attachment[:file_name]
        })
  end

  def renderable
    Base64.encode64(file_contents)
  end

  private

  def self.sanitize_filename(file_name)
    return File.basename(file_name)
  end

end
