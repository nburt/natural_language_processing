require './app/models/format_csv'

describe 'FormatCsv' do
  it "returns csv data for a query result" do
    input = [
      {
        "text" => "Nathanael Burt",
        "count" => 1,
        "relevance" => "0.969646"
      },
      {
        "text" => "Irvine",
        "count" => nil,
        "relevance" => "0.618389"
      }
    ]
    expected = "Text,Count,Relevance\nNathanael Burt,1,0.969646\nIrvine,,0.618389\n"
    expect(FormatCsv.call(input)).to eq expected
  end
end