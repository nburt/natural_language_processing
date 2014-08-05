class AlchemyController < ApplicationController

  def create
    options_hash = {maxRetrieve: params[:alchemy_api][:max_retrieve]}
    file = params[:alchemy_api][:file].read
    analysis = TextProcessor.analyze(file, options_hash)
    response = TextFormatter.format(analysis)
    query = Query.create!(response: response)
    redirect_to query_path(query)
  end

end