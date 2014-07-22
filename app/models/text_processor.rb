require './lib/assets/alchemyapi'

class TextProcessor

  def self.analyze(analysis_type, file)
    if analysis_type.to_i == 1
      entity_request(file)
    end
  end

  private

  def self.entity_request(file)
    alchemy_api = AlchemyAPI.new
    alchemy_api.entities('text', file, {sentiment: 1, showSourceText: 1})
  end

end