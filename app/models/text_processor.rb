require './lib/assets/alchemyapi'

class TextProcessor

  def self.analyze(analysis_type, file, options = {})
    if analysis_type.to_i == 1
      entity_request(file, options)
    end
  end

  private

  def self.entity_request(file, options)
    alchemy_api = AlchemyAPI.new
    alchemy_api.entities('text', file, options)
  end

end