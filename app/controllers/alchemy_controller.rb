class AlchemyController < ApplicationController

  def result
    analysis_type = params[:alchemy_api][:entity_analysis]
    file = params[:alchemy_api][:file].read
    analysis = TextProcessor.analyze(analysis_type, file)
    render json: analysis
  end

end