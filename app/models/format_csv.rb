require 'csv'

FormatCsv = ->(query_response) do
  headers = ["Text", "Count", "Relevance"]
  CSV.generate do |csv|
    csv << headers
    query_response.each do |term|
      csv << [term['text'], term['count'], term['relevance']]
    end
  end
end