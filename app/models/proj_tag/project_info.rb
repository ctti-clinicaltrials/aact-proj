module ProjTag
  class ProjectInfo

    def self.meta_info
      #  Required:  name, schema_name & migration_file_name
      { name:                'Aggregated Set of Tagged MeSH Terms',
        schema_name:         'proj_tag',
        migration_file_name:  Rails.root.join('db','migrate','20180719000122_create_proj_tag_tables.rb').to_s,
        organizations:        'Duke Clinical Research Institute',
        start_date:           Date.strptime('27/09/2010', '%d/%m/%Y'),
        year:                 2010,
      }
    end

    def self.publications
      []
    end

    def self.datasets
      []
    end

    def self.attachments
      [
        {
          file_name: "#{Rails.public_path}/incoming/2010_free_tagged_terms.xlsx",
          file_type: 'application/vnd.openxmlformats-officedocument.spreads'
        },
        {
          file_name: "#{Rails.public_path}/incoming/2010_mesh_tagged_terms.xlsx",
          file_type: 'application/vnd.openxmlformats-officedocument.spreads'
        },
        {
          file_name: "#{Rails.public_path}/incoming/2016_free_tagged_terms.xlsx",
          file_type: 'application/vnd.openxmlformats-officedocument.spreads'
        },
        {
          file_name: "#{Rails.public_path}/incoming/2016_mesh_tagged_terms.xlsx",
          file_type: 'application/vnd.openxmlformats-officedocument.spreads'
        },
        {
          file_name: "#{Rails.public_path}/incoming/2017_free_tagged_terms.xlsx",
          file_type: 'application/vnd.openxmlformats-officedocument.spreads'
        },
        {
          file_name: "#{Rails.public_path}/incoming/2017_mesh_tagged_terms.xlsx",
          file_type: 'application/vnd.openxmlformats-officedocument.spreads'
        },
      ]
    end

    def self.load_project_tables
      ProjTag::TaggedTerm.populate
    end

  end
end
