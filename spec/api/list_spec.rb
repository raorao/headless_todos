require "rails_helper"


describe Lists::API do

  describe 'POST /lists' do
    it "creates a new list" do
      expect { post '/lists', { name: 'list name'} }.to change{ List.count }.by 1
    end
  end
end