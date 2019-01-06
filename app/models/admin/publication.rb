module Admin
  class Publication < AdminBase
    belongs_to :project
  end
end
