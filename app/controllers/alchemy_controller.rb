class AlchemyController < ApplicationController

  def query
    options_hash = create_options_hash(params[:alchemy_api])
    analysis_type = params[:alchemy_api][:entity_analysis]
    file = params[:alchemy_api][:file].read
    analysis = TextProcessor.analyze(analysis_type, file, options_hash)
    @response = TextFormatter.format(analysis)
    render 'alchemy/result'
  end

  private

  def create_options_hash(alchemy_api_params)
    {
      showSourceText: alchemy_api_params[:source_text],
      sentiment: alchemy_api_params[:sentiment],
      disambiguate: alchemy_api_params[:disambiguate],
      linkedData: alchemy_api_params[:linked_data],
      coreference: alchemy_api_params[:coreference],
      quotations: alchemy_api_params[:quotations],
      maxRetrieve: alchemy_api_params[:max_retrieve],
    }
  end

end