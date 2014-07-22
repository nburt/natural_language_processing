class UnknownEntity < StandardError
end

class TextFormatter
  def self.format(response)
    hash = {}
    array = []
    hash[:source_text] = response["text"]
    response["entities"].each do |entity|
      array << {
        type: entity["type"],
        relevance: entity["relevance"],
        sentiment_type: entity["sentiment"]["type"],
        sentiment_score: entity["sentiment"]["score"],
        count: entity["count"].to_i,
        text: entity["text"],
        disambiguated: entity["disambiguated"]
      }
    end
    hash[:entities] = array
    hash
  end
end