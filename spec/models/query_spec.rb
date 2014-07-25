require 'rails_helper'

describe Query do

  describe "#response_json" do

    it "can take a hash and return a hash" do
      query = Query.new(response_json: {"hay" => "hallooo"})
      expect(query.response_json).to eq({"hay" => "hallooo"})
      query.save!
      expect(Query.find(query.id).response_json).to eq({"hay" => "hallooo"})
    end

  end

end