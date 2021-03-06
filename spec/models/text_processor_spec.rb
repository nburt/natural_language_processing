require 'rails_helper'

describe TextProcessor do
  describe "Entity Analysis" do
    it 'defaults to the most basic entity analysis' do
      VCR.use_cassette('/alchemy/default') do
        expected_entities = {
          "status" => "OK",
          "usage" =>
            "By accessing AlchemyAPI or using information generated by AlchemyAPI, you are agreeing to be bound by the AlchemyAPI Terms of Use: http://www.alchemyapi.com/company/terms.html",
          "url" => "",
          "language" => "english",
          "entities" => [
            {
              "type" => "Person",
              "relevance" => "0.969646",
              "count" => "1",
              "text" => "Nathanael Burt"
            },
            {
              "type" => "City",
              "relevance" => "0.369666",
              "count" => "1",
              "text" => "Irvine",
            },
            {
              "type" => "StateOrCounty",
              "relevance" => "0.293316",
              "count" => "1",
              "text" => "CA"
            }
          ]
        }

        expected_keywords = {
          "status" => "OK",
          "usage" => "By accessing AlchemyAPI or using information generated by AlchemyAPI, you are agreeing to be bound by the AlchemyAPI Terms of Use: http://www.alchemyapi.com/company/terms.html",
          "url" => "",
          "language" => "english",
          "keywords" => [
            {
              "text" => "Nathanael Burt",
              "relevance" => "0.948501"
            },
            {
              "text" => "Irvine",
              "relevance" => "0.618389"
            },
            {
              "text" => "CA",
              "relevance" => "0.432386"
            }
          ]
        }

        result = TextProcessor.analyze(File.read("./spec/support/test.txt"))
        expect(result.entities).to eq expected_entities
        expect(result.keywords).to eq expected_keywords
      end
    end

    it 'allows you to specify the maxRetrieve value' do
      VCR.use_cassette('/alchemy/max_retrieve_only') do
        expected_entities = {
          "status" => "OK",
          "usage" =>
            "By accessing AlchemyAPI or using information generated by AlchemyAPI, you are agreeing to be bound by the AlchemyAPI Terms of Use: http://www.alchemyapi.com/company/terms.html",
          "url" => "",
          "language" => "english",
          "entities" => [
            {
              "type" => "Person",
              "relevance" => "0.969646",
              "count" => "1",
              "text" => "Nathanael Burt"
            }
          ]
        }

        expected_keywords = {
          "status" => "OK",
          "usage" => "By accessing AlchemyAPI or using information generated by AlchemyAPI, you are agreeing to be bound by the AlchemyAPI Terms of Use: http://www.alchemyapi.com/company/terms.html",
          "url" => "",
          "language" => "english",
          "keywords" => [
            {
              "text" => "Nathanael Burt", "relevance" => "0.948501"
            }
          ]
        }

        result = TextProcessor.analyze(File.read("./spec/support/test.txt"), {maxRetrieve: "1"})
        expect(result.entities).to eq expected_entities
        expect(result.keywords).to eq expected_keywords
      end
    end
  end
end