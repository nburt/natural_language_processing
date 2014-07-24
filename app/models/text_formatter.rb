class TextFormatter
  def self.format(response)
    entities = entities_array(response.entities)
    keywords = keywords_array(response.keywords)
    entities.concat(keywords).sort_by { |term| term[:relevance] }.reverse
  end

  private

  def self.entities_array(entities_response)
    entities_response["entities"].map do |entity|
      {
        text: entity["text"],
        count: entity["count"].to_i,
        relevance: entity["relevance"]
      }
    end
  end

  def self.keywords_array(keywords_response)
    keywords_response["keywords"].map do |keyword|
      {
        text: keyword["text"],
        count: nil,
        relevance: keyword["relevance"]
      }
    end
  end
end