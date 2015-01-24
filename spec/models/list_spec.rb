require 'rails_helper'

describe List do
  describe 'validations' do
    it "is only valid if the name value is URI encodable" do
      list = List.create name: 'foo bar'
      expect(list).not_to be_valid
    end

    it "is only valid if the list name is unique" do
      List.create name: 'non_unique_name'

      list = List.create name: 'non_unique_name'
      expect(list).not_to be_valid
    end
  end
end