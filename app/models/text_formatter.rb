class UnknownEntity < StandardError
end

class TextFormatter
  def self.format(response)
    hash = {}
    array = []
    hash[:source_text] = response["text"]
    response["entities"].each do |entity|
      if entity["type"] == "Person"
        array << person_hash(entity)
      elsif entity["type"] == "City"
        array << city_hash(entity)
      elsif entity["type"] == "StateOrCounty"
        array << state_county_hash(entity)
      else
        raise UnknownEntity, "Please send Nate an email"
      end
    end
    hash[:entities] = array
    hash
  end

  private

  def self.person_hash(entity)
    {
      type: "Person",
      relevance: entity["relevance"],
      sentiment_type: entity["sentiment"]["type"],
      sentiment_score: entity["sentiment"]["score"],
      count: entity["count"].to_i,
      text: entity["text"]
    }
  end

  def self.city_hash(entity)
    {
      type: "City",
      relevance: entity["relevance"],
      sentiment_type: entity["sentiment"]["type"],
      sentiment_score: entity["sentiment"]["score"],
      count: entity["count"].to_i,
      text: entity["text"],
      disambiguated: entity["disambiguated"]
    }
  end

  def self.state_county_hash(entity)
    {
      type: "State or County",
      relevance: entity["relevance"],
      sentiment_type: entity["sentiment"]["type"],
      sentiment_score: entity["sentiment"]["score"],
      count: entity["count"].to_i,
      text: entity["text"]
    }
  end

end