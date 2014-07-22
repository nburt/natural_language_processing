require 'rails_helper'

feature 'visiting the homepage' do
  scenario 'a user can visit the homepage and will see text' do
    visit '/'
    expect(page).to have_content 'Natural Language Processing'
  end
end