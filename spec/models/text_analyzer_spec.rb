require 'rails_helper'

describe TextAnalyzer do
  it 'processes text, formats it, and then creates a new query object' do
    VCR.use_cassette('/models/text_analyzer') do
      file = File.read('./spec/support/test.txt')
      options = {maxRetrieve: "1"}
      query, status = TextAnalyzer.query(file, options)
      expect(query.response).to eq [
                                     {
                                       "text" => "Nathanael Burt",
                                       "count" => 1,
                                       "relevance" => "0.969646"
                                     }
                                   ]
      expect(status).to eq 200
    end
  end

  it 'handles when a query does not save' do
    VCR.use_cassette('/models/text_analyzer_error') do
      file = nil
      query, status = TextAnalyzer.query(file)
      expect(Query.last.response).to eq query.response
      expect(query.response).to eq(
                                  {
                                    "status" => 400,
                                    "error" => "Query could not be processed, file is either blank or larger than 50kb"
                                  }
                                )
      expect(status).to eq 400
    end
  end
end