require 'rails_helper'

RSpec.describe Admin::Project, type: :model do
  context 'gets saved' do
     before(:all) do
      @title='project title'
      @person='an investigator'
      @url='https://testurl.com'
      @start_date='2011-09-26'.to_date
      @issues='We had problems'
      @pub=Admin::Publication.create({:url => @url})
      @project=Admin::Project.new({:start_date => @start_date,
                                   :year => @start_date.year,
                                   :investigators => @person,
                                   :issues => @issues,
                                   :publications => [@pub] })
      @project.save!
    end

    it 'has expected attribute values' do
      expect(@project.investigators).to eq(@person)
      expect(@project.issues).to eq(@issues)
    end

    it 'is linked to related publications' do
      expect(@project.publications.size).to eq(1)
      expect(@project.publications.first.url).to eq(@url)
    end

  end

end
