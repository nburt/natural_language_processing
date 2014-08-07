require 'rails_helper'

feature 'visiting the homepage' do
  scenario 'a user can visit the homepage and request an entity analysis of a text file' do
    VCR.use_cassette('/features/default') do
      visit '/'
      expect(page).to have_content 'Natural Language Processing'
      attach_file('alchemy_api[file]', './spec/support/test.txt')
      click_button 'Upload File'
      query = Query.last
      expect(page.current_path).to eq "/query/#{query.id}"
      expect(page).to have_content '1'
      expect(page).to have_content 'Text'
      expect(page).to have_content 'Count'
      expect(page).to have_content 'Relevance'
      expect(page).to have_content 'Nathanael Burt'
      expect(page).to have_content 'Irvine'
      expect(page).to have_content 'CA'
      expect(page).to have_content '0.969646'
      click_link 'Make another request'
      expect(page).to have_content 'Natural Language Processing'
    end
  end

  scenario 'allows you to configure the maxRetrieve' do
    VCR.use_cassette('/features/configuration') do
      visit '/'
      fill_in 'alchemy_api[max_retrieve]', with: '2'
      attach_file('alchemy_api[file]', './spec/support/test_3.txt')
      click_button 'Upload File'

      expect(page).to have_content '0.977758'
      expect(page).to have_content '1'
    end
  end

  scenario 'allows you to download a csv of the data' do
    VCR.use_cassette('/features/csv') do
      visit '/'
      attach_file('alchemy_api[file]', './spec/support/test_3.txt')
      click_button 'Upload File'

      click_link 'Download as CSV'
      query = Query.last
      expect(page.current_path).to eq "/query/#{query.id}.csv"
    end
  end

  scenario 'handles the upload of an empty file' do
    VCR.use_cassette('/features/empty_file_upload') do
      visit '/'
      click_button 'Upload File'

      expect(page).to have_content 'File cannot be empty'
    end
  end

  scenario 'handles files that are too big' do
    VCR.use_cassette('/features/filesize_error') do
      visit '/'
      attach_file('alchemy_api[file]', './spec/support/too_big.txt')
      click_button 'Upload File'
      expect(page).to have_content 'Query could not be processed, file is either blank or larger than 50kb'
    end
  end

end