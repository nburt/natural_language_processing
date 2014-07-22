require 'rails_helper'

describe TextFormatter do
  it 'can format an alchemy response into an array of hashes' do
    input = {
      "status" => "OK",
      "usage" =>
        "By accessing AlchemyAPI or using information generated by AlchemyAPI, you are agreeing to be bound by the AlchemyAPI Terms of Use: http://www.alchemyapi.com/company/terms.html",
      "url" => "",
      "totalTransactions" => "2",
      "language" => "english",
      "text" => "Hello, my name is Nathanael Burt. I'm from Irvine, CA",
      "entities" =>
        [{"type" => "Person",
          "relevance" => "0.968376",
          "sentiment" => {"type" => "negative", "score" => "-0.364699"},
          "count" => "1",
          "text" => "Nathanael Burt"},
         {"type" => "City",
          "relevance" => "0.390811",
          "sentiment" => {"type" => "neutral"},
          "count" => "1",
          "text" => "Irvine",
          "disambiguated" =>
            {"subType" => ["AdministrativeDivision"],
             "name" => "Irvine, California",
             "website" => "http://www.cityofirvine.org/",
             "dbpedia" => "http://dbpedia.org/resource/Irvine,_California",
             "freebase" => "http://rdf.freebase.com/ns/m.0d7k1z",
             "geonames" => "http://sws.geonames.org/5359777/",
             "yago" => "http://yago-knowledge.org/resource/Irvine,_California"}},
         {"type" => "StateOrCounty",
          "relevance" => "0.292176",
          "sentiment" => {"type" => "neutral"},
          "count" => "1",
          "text" => "CA"}
        ]
    }

    output = {
      source_text: "Hello, my name is Nathanael Burt. I'm from Irvine, CA",
      entities: [
        {
          :type => "Person",
          :relevance => "0.968376",
          :sentiment_type => "negative",
          :sentiment_score => "-0.364699",
          :count => 1,
          :text => "Nathanael Burt",
          :disambiguated => nil
        },
        {
          :type => "City",
          :relevance => "0.390811",
          :sentiment_type => "neutral",
          :sentiment_score => nil,
          :count => 1,
          :text => "Irvine",
          :disambiguated => {
            "subType" => ["AdministrativeDivision"],
            "name" => "Irvine, California",
            "website" => "http://www.cityofirvine.org/",
            "dbpedia" => "http://dbpedia.org/resource/Irvine,_California",
            "freebase" => "http://rdf.freebase.com/ns/m.0d7k1z",
            "geonames" => "http://sws.geonames.org/5359777/",
            "yago" => "http://yago-knowledge.org/resource/Irvine,_California"
          }
        },
        {
          :type => "StateOrCounty",
          :relevance => "0.292176",
          :sentiment_type => "neutral",
          :sentiment_score => nil,
          :count => 1,
          :text => "CA",
          :disambiguated => nil
        }
      ]
    }

    expect(TextFormatter.format(input)).to eq output
  end
end