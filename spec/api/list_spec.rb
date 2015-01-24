require "rails_helper"


describe Lists::API do

  describe 'POST /lists' do
    it "creates a new list" do
      expect { post '/lists', {name: 'list-name'} }.to change{ List.count }.by 1
    end

    describe 'if a list with the same name already exists' do
      before(:each) do
        List.create name: 'non-unique-name'
      end

      it "doesn't create a new list" do
        expect { post '/lists', {name: 'non-unique-name'} }.to change{ List.count }.by 0
      end

      it "returns a 500 status error" do
        post '/lists', {name: 'non-unique-name'}
        expect(response.status).to eq 422
      end
    end
  end

  describe 'POST /lists/:name/item' do
    let(:list) {List.create name: 'list_name'}

    it 'creates a new item for the associated list' do
      expect {
        post "/lists/#{list.name}/items", {description: 'some description', completed: false }
      }.to change{ Item.count }.by 1
    end

    it 'returns a json representation of the item' do
      post "/lists/#{list.name}/items", {description: 'some description', completed: false }
      expect(response.body).to eq Item.last.to_json
    end
  end

  describe 'PUT /lists/:name/items/:item_id' do
    let(:list) {List.create name: 'list_name'}
    let(:item) {list.items.create description: 'item_description', completed: false}

    it 'updates the specified item' do
      put "/lists/#{list.name}/items/#{item.id}", {completed: true}
      item.reload
      expect(item.completed).to equal true
    end

    it 'returns a json representation of the item' do
      put "/lists/#{list.name}/items/#{item.id}", {completed: true}
      expect(response.body).to eq item.reload.to_json
    end

  end

  describe 'PUT /lists/:name/items/:item_id' do
    let(:list) {List.create name: 'list_name'}
    let(:item) {list.items.create description: 'item_description', completed: false}

    it 'updates the specified item' do
      expect {
        delete "/lists/#{list.name}/items/#{item.id}"
        }.to change{Item.count}.by 0
    end
  end

end