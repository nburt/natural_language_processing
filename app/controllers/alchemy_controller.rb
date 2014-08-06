class AlchemyController < ApplicationController

  def create
    file = params[:alchemy_api][:file].read
    options_hash = {maxRetrieve: params[:alchemy_api][:max_retrieve]}
    query = TextAnalyzer.query(file, options_hash)
    redirect_to query_path(query)
  end

end