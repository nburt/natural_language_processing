class QueryController < ApplicationController

  def show
    query = Query.find(params[:id])
    @response = JSON.parse(query.response.first)
  end

end