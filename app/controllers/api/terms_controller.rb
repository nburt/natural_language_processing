module Api
  class TermsController < ActionController::Base

    def create
      params = JSON.parse(request.body.read)
      file = params["source_text"]
      options_hash = {maxRetrieve: params["max_retrieve"]}
      query = TextAnalyzer.query(file, options_hash)
      json = {
        query_id: query.id,
        created_at: query.created_at,
        terms: query.response
      }
      render json: json
    end

  end
end