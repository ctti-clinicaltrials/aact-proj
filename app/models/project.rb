class Project < ActiveRecord::Base
  has_many :publications
  has_many :datasets

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |proj|
        csv << proj.attributes.values_at(*column_names)
      end
    end
  end
end
