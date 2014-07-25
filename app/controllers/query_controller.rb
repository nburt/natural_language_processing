require 'csv'
class QueryController < ApplicationController

  def show
    @query = Query.find(params[:id])
    @response = @query.response_json

    respond_to do |format|
      format.csv do
        headers = ["Text", "Count", "Relevance"]
        data = CSV.generate do |csv|
          csv << headers
          @response.each do |term|
            csv << [term['text'], term['count'], term['relevance']]
          end
        end
        send_data data, filename: "#{@query.filename}_glossary.csv"
      end

      format.html
    end
  end

end