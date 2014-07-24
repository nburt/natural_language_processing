require './lib/assets/alchemyapi'

class TextProcessor

  def self.analyze(file, options = {})
    alchemy_api = AlchemyAPI.new
    entity_response = entity_request(alchemy_api, file, options)
    keyword_response = keyword_request(alchemy_api, file, options)
    response = Struct.new(:entities, :keywords)
    response.new(entity_response, keyword_response)
  end

  private

  def self.entity_request(alchemy_api, file, options)
    alchemy_api.entities('text', file, options.merge({disambiguate: "0", coreference: "0", linkedData: "0"}))
  end

  def self.keyword_request(alchemy_api, file, options)
    alchemy_api.keywords('text', file, options)
  end

end