require 'rails_helper'

describe Query do

  describe "#response" do

    it "can take a hash and return a hash" do
      query = Query.new(response: {"hay" => "hallooo"})
      expect(query.response).to eq({"hay" => "hallooo"})
      query.save!
      expect(Query.find(query.id).response).to eq({"hay" => "hallooo"})
    end

  end

  describe "validations" do
    it "validates presence of a response" do
      query = Query.create!(response: [{"text" => "Nathanael Burt","count" => 1,"relevance" => "0.969646"}])
      expect(query).to be_valid
      query.response = nil
      expect(query).to_not be_valid
    end
  end

end