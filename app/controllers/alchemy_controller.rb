class AlchemyController < ApplicationController

  def create
    options_hash = {maxRetrieve: params[:alchemy_api][:max_retrieve]}
    file = params[:alchemy_api][:file].read
    filename = params[:alchemy_api][:file].original_filename
    analysis = TextProcessor.analyze(file, options_hash)
    response = TextFormatter.format(analysis)
    query = Query.create!(response: response, filename: filename)
    redirect_to query_path(query)
  end

end