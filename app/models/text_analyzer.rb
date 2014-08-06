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
    Query.create!(response: response)
  end

end