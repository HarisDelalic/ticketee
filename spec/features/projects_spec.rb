require 'rails_helper'

describe 'Creating Projets', type: :feature do

  scenario 'can create a project', js: true do
    visit root_path

    click_link 'New Project'

    fill_in 'Name', with: 'TextMate 2'
    fill_in 'Description', with: 'A text-editor for OS X'
    click_button 'Create Project'

    expect(page).to have_content('Project has been created.')
  end
end