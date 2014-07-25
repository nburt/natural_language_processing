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

end