class UnknownEntity < StandardError
end

class TextFormatter
  def self.format(response)
    hash = {}
    array = []
    hash[:source_text] = response["text"]
    response["entities"].each do |entity|
      entity_hash = {}
      entity_hash[:type] = entity["type"]
      entity_hash[:relevance] = entity["relevance"]
      if entity["sentiment"]
        entity_hash[:sentiment_type] = entity["sentiment"]["type"]
        entity_hash[:sentiment_score] = entity["sentiment"]["score"]
      else
        entity_hash[:sentiment_type] = nil
        entity_hash[:sentiment_score] = nil
      end
      entity_hash[:count] = entity["count"].to_i
      entity_hash[:text] = entity["text"]
      if entity["disambiguated"]
        entity_hash[:disambiguated] = entity["disambiguated"]
      else
        entity_hash[:disambiguated] = nil
      end
      if entity["quotations"]
        entity_hash[:quotations] = entity["quotations"]
      else
        entity_hash[:quotations] = nil
      end
      array << entity_hash
    end
    hash[:entities] = array
    hash
  end
end