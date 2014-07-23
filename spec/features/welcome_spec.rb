require 'rails_helper'

feature 'visiting the homepage' do
  scenario 'a user can visit the homepage and request an entity analysis of a text file' do
    VCR.use_cassette('/features/default') do
      visit '/'
      expect(page).to have_content 'Natural Language Processing'
      expect(page).to have_content 'Select the analysis type'
      select 'Entity Analysis'
      check 'alchemy_api[source_text]'
      check 'alchemy_api[sentiment]'
      attach_file('alchemy_api[file]', './spec/support/test.txt')
      click_button 'Upload File'
      expect(page).to have_content 'Source Text'
      expect(page).to have_content "Hello, my name is Nathanael Burt. I'm from Irvine, CA"
      expect(page).to have_content '1'
      expect(page).to have_content 'Text'
      expect(page).to have_content 'Type'
      expect(page).to have_content 'Relevance'
      expect(page).to have_content 'Sentiment Type'
      expect(page).to have_content 'Sentiment Score'
      expect(page).to have_content 'Disambiguation Data'
      expect(page).to have_content 'Quotations'
      expect(page).to have_content 'Nathanael Burt'
      expect(page).to have_content 'Irvine'
      expect(page).to have_content 'CA'
      expect(page).to have_content 'Person'
      expect(page).to have_content 'City'
      expect(page).to have_content 'StateOrCounty'
      expect(page).to have_content '0.969646'
      expect(page).to have_content 'negative'
      expect(page).to have_content '-0.364699'
      expect(page).to have_content 'Name: Irvine, California'
      expect(page).to have_content 'Website: http://www.cityofirvine.org/'
      expect(page).to have_content 'DBpedia: http://dbpedia.org/resource/Irvine,_California'
      expect(page).to have_content 'Freebase: http://rdf.freebase.com/ns/m.0d7k1z'
      expect(page).to have_content 'Geonames: http://sws.geonames.org/5359777/'
      expect(page).to have_content 'Yago: http://yago-knowledge.org/resource/Irvine,_California'
      click_link 'Make another request'
      expect(page).to have_content 'Natural Language Processing'
    end
  end

  it 'allows you to configure the maxRetrieve, disambiguate, linkedData, coreference, and quotations' do
    VCR.use_cassette('/features/configuration') do
      visit '/'
      select 'Entity Analysis'
      check 'alchemy_api[source_text]'
      check 'alchemy_api[sentiment]'
      check 'alchemy_api[disambiguate]'
      check 'alchemy_api[linked_data]'
      check 'alchemy_api[coreference]'
      check 'alchemy_api[quotations]'
      fill_in 'alchemy_api[max_retrieve]', with: '2'
      attach_file('alchemy_api[file]', './spec/support/test_3.txt')
      click_button 'Upload File'

      expect(page).to have_content "Hello, my name is Nathanael Burt. He said \"I'm from Irvine, CA\""
      expect(page).to have_content 'Person'
      expect(page).to have_content 'negative'
      expect(page).to have_content '0.977758'
      expect(page).to have_content '1'
      expect(page).to have_content 'Irvine'
      expect(page).to_not have_content 'http://www.cityofirvine.org/'
      expect(page).to_not have_content 'http://dbpedia.org/resource/Irvine,_California'
    end
  end
end