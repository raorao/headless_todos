require "rails_helper"


describe Lists::API do

  describe 'POST /lists' do
    it "creates a new list" do
      expect { post '/lists', {name: 'list name'} }.to change{ List.count }.by 1
    end

    describe 'if a list with the same name already exists' do
      before(:each) do
        List.create name: 'non-unique name'
      end

      it "doesn't create a new list" do
        expect { post '/lists', {name: 'non-unique name'} }.to change{ List.count }.by 0
      end

      it "returns a 500 status error" do
        post '/lists', {name: 'non-unique name'}
        expect(response.status).to eq 422
      end
    end
  end
end