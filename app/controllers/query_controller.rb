require 'csv'
class QueryController < ApplicationController

  def show
    @query = Query.find(params[:id])
    @response = JSON.parse(@query.response.first)

    respond_to do |format|
      format.csv do
        headers = ["Text", "Type", "Count", "Relevance", "Sentiment Type", "Sentiment Score", "Disambiguation Data", "Quotations"]
        data = CSV.generate do |csv|
          csv << headers
          @response["entities"].each do |term|
            csv << [term['text'], term['type'], term['count'], term['relevance'], term['sentiment_type'], term['sentiment_score'], term['disambiguated'], term['quotations']]
          end
        end
        send_data data, filename: "#{@query.filename}_glossary.csv"
      end

      format.html
    end
  end

end