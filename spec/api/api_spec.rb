require 'rails_helper'

describe "posting NLP queries" do
  describe "POST /api/query" do
    it 'takes json with a source text and will return json with the keywords' do
      VCR.use_cassette '/api/query' do
        query_count = Query.count

        body = {
          source_text: "Hello, my name is Nathanael Burt. I'm from Irvine, CA."
        }.to_json

        post '/api/terms', body, {'Accept' => 'application/json'}
        expect(Query.count).to eq(query_count + 1)
        query = Query.last

        expected_response = {
          query_id: query.id,
          created_at: query.created_at,
          terms: [
            {
              :text => "Nathanael Burt",
              :count => 1,
              :relevance => "0.969646"
            },
            {
              :text => "Irvine",
              :count => nil,
              :relevance => "0.618389"
            },
            {
              :text => "CA",
              :count => nil,
              :relevance => "0.432386"
            }
          ]
        }.to_json

        expect(response.body).to eq expected_response
      end
    end

    it 'allows you to specify the maxRetrieve' do
      VCR.use_cassette '/api/query_with_max_retrieve' do
        body = {
          source_text: "Hello, my name is Nathanael Burt. I'm from Irvine, CA.",
          max_retrieve: "2"
        }.to_json

        post '/api/terms', body, {'Accept' => 'application/json'}
        query = Query.last

        expected_response = {
          query_id: query.id,
          created_at: query.created_at,
          terms: [
            {
              :text => "Nathanael Burt",
              :count => 1,
              :relevance => "0.969646"
            },
            {
              :text => "Irvine",
              :count => nil,
              :relevance => "0.618389"
            }
          ]
        }.to_json

        expect(response.body).to eq expected_response
      end
    end

    it 'handles empty files does not save' do
      VCR.use_cassette '/api/file_error' do
        post '/api/terms', nil, {'Accept' => 'application/json'}

        expect(response.status).to eq 400
        expect(response.body).to eq(
                                   {
                                     status: 400,
                                     error: 'File cannot be empty'
                                   }.to_json
                                 )

        post '/api/terms', '', {'Accept' => 'application/json'}

        expect(response.status).to eq 400
        expect(response.body).to eq(
                                   {
                                     status: 400,
                                     error: 'File cannot be empty'
                                   }.to_json
                                 )
      end
    end

    it 'returns an error message if the file is too big' do
      VCR.use_cassette '/api/filesize_error' do
        body = {
          source_text: File.read('./spec/support/too_big.txt')
        }.to_json

        post '/api/terms', body, {'Accept' => 'application/json'}

        expect(response.status).to eq 400
        expect(response.body).to eq(
                                   {
                                     status: 400,
                                     error: 'Query could not be processed, file is either blank or larger than 50kb'
                                   }.to_json
                                 )
      end
    end

  end
end