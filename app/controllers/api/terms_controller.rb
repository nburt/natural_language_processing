module Api
  class TermsController < ActionController::Base

    def create
      params = JSON.parse(request.body.read)
      file = params["source_text"]
      options_hash = {maxRetrieve: params["max_retrieve"]}
      analysis = TextProcessor.analyze(file, options_hash)
      response = TextFormatter.format(analysis)
      query = Query.create!(response: response)
      json = {
        query_id: query.id,
        created_at: query.created_at,
        terms: response
      }
      render json: json
    end

  end
end