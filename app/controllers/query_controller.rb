require 'csv'
class QueryController < ApplicationController

  def show
    @query = Query.find(params[:id])
    @response = @query.response

    respond_to do |format|
      format.csv do
        send_data FormatCsv.call(@response), filename: "#{@query.id}_glossary.csv"
      end

      format.html
    end
  end

end