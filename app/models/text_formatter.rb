class TextFormatter
  def self.format(response)
    entities = entities_array(response.entities)
    keywords = keywords_array(response.keywords)
    unique_terms = extract_unique_terms(entities.concat(keywords))
    unique_terms.sort_by { |term| term[:relevance] }.reverse
  end

  private

  def self.extract_unique_terms(terms)
    sorted_by_term = terms.sort_by { |term| term[:text] }
    array = sorted_by_term
    sorted_by_term.each_with_index do |term, index|
      if term[:text].downcase == sorted_by_term[index - 1][:text].downcase
        least_relevant = find_most_relevant(term, sorted_by_term[index - 1])
        array.delete(least_relevant)
      end
    end
    array
  end

  def self.find_most_relevant(term1, term2)
    if term1[:relevance].to_f < term2[:relevance].to_f
      term1
    else
      term2
    end
  end

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