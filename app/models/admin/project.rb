module Admin
  class Project < AdminBase
    has_many :attachments
    has_many :datasets
    has_many :publications
  end
end
