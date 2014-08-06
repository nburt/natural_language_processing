class AlchemyController < ApplicationController

  def create
    begin
      file = params[:alchemy_api][:file].read
      options_hash = {maxRetrieve: params[:alchemy_api][:max_retrieve]}
      query, _ = TextAnalyzer.query(file, options_hash)
      redirect_to query_path(query)
    rescue NoMethodError
      flash[:empty_file] = "File cannot be empty"
      render 'welcome/index'
    end
  end

end