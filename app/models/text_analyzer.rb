class TextAnalyzer

  def self.query(file, options = {})
    analysis = analyze(file, options)
    response = format_analysis(analysis)
    create_query(response)
  end

  private

  def self.analyze(file, options)
    TextProcessor.analyze(file, options)
  end

  def self.format_analysis(analysis)
    TextFormatter.format(analysis)
  end

  def self.create_query(response)
    query = Query.new(response: response)
    if query.save
      [query, 200]
    else
      [
        query_error,
        400
      ]
    end
  end

  def self.query_error
    response = {
      status: 400,
      error: "Query could not be processed, file is either blank or larger than 50kb"
    }
    Query.create!(response: response)
  end

end