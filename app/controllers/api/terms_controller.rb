module Api
  class TermsController < ActionController::Base

    def create
      begin
        params = JSON.parse(request.body.read)
        file = params["source_text"]
        options_hash = {maxRetrieve: params["max_retrieve"]}
        query, status = TextAnalyzer.query(file, options_hash)
        if status == 200
          json = json_success(query)
        end
      rescue JSON::ParserError
        json = json_parser_error
        status = 400
      end
      render json: json, status: status
    end

    private

    def json_success(query)
      {
        query_id: query.id,
        created_at: query.created_at,
        terms: query.response
      }
    end

    def json_parser_error
      {
        status: 400,
        error: "File cannot be empty"
      }
    end

  end
end