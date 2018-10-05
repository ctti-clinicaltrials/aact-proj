class Project < ActiveRecord::Base
  has_many :attachments,  :dependent => :destroy
  has_many :datasets,     :dependent => :destroy
  has_many :publications, :dependent => :destroy
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create


  def self.populate(proj_name)
    proj= Project.new( ProjAnderson::ProjectInfo.meta_info )
    puts  proj.name
    reset_existing(proj)
  end

  def reset_existing(proj)
    Project.where('schema_name=?',proj.schema_name).each {|p|  p.destroy }
    con=ActiveRecord::Base.establish_connection(ENV['AACT_PUBLIC_DATABASE_URL']).connection
    exists = con.execute("SELECT schema_name FROM information_schema.schemata WHERE schema_name = #{proj.schema_name};").values
    con.execute("DROP SCHEMA #{proj.schema_name} CASCADE;") if !exists.empty?
    con.execute("CREATE SCHEMA #{proj.schema_name};")
    con.execute("GRANT USAGE ON SCHEMA #{proj.schema_name} to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
    con.execute("GRANT CREATE ON SCHEMA #{proj.schema_name} to #{ENV['AACT_PROJ_DB_SUPER_USERNAME']};")
    con.execute("GRANT SELECT ON all tables in SCHEMA #{proj.schema_name} to public;")
    require proj.migration_file_name
    require "db/migrate/20090408054532_add_foos.rb"
    AddFoos.up
  end






  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |uc|
        csv << uc.attributes.values_at(*column_names)
      end
    end
  end

  def initialize(params = {})
    file = params.delete(:file)
    image_file = params.delete(:image_file)
    super
    self.attachments << Attachment.create_from(file) if file and attachment.nil?
    self.attachments << Attachment.create_from(image_file,'image') if image_file and image.nil?
    self
  end

  def update(params = {})
    file = params.delete(:file)
    image_file = params.delete('image_file')
    self.attachments = []
    self.attachments << Attachment.create_from(file) if file
    self.attachments << Attachment.create_from(image_file,'image') if image_file
    super
    self
  end

  def current_image_file_name
    image.try(:file_name)
  end

  def current_attachment_file_name
    attachment.try(:file_name)
  end

  def file
    attachment.try(:file_name)
  end

  def linkable_url
    return nil if self.url.blank?
    if self.url.match(/^http:\/\//) or self.url.match(/^https:\/\//)
      self.url
    else
      "http://#{self.url}"
    end
  end

  def attachment
    attachments.select{|uca|!uca.is_image}.first
  end

  def image
    attachments.select{|uca|uca.is_image}.first
  end

end
