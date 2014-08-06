require 'rails_helper'

describe TextAnalyzer do
  it 'processes text, formats it, and then creates a new query object' do
    VCR.use_cassette('/models/text_analyzer') do
      file = File.read('./spec/support/test.txt')
      options = {maxRetrieve: "1"}
      result = TextAnalyzer.query(file, options)
      expect(result.response).to eq [
                                      {
                                        "text" => "Nathanael Burt",
                                        "count" => 1,
                                        "relevance" => "0.969646"
                                      }
                                    ]
    end
  end
end