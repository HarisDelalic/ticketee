require 'rails_helper'

describe 'Creating Projets', type: :feature do

  scenario 'can create a project', js: true do
    visit root_path

    click_link 'New Project'

    fill_in 'Name', with: 'TextMate 2'
    fill_in 'Description', with: 'A text-editor for OS X'
    click_button 'Create Project'

    expect(page).to have_content('Project has been created.')
    title = "TextMate 2 - Projects - Ticketee"
    expect(page).to have_title(title)
  end
end

describe 'Show project', type: :feature do
  scenario 'title is properly set', js: true do
    project = create :project, name: 'TextMate 2', description: 'A text-editor for OS X'

    visit project_path(project)

    expect(page.current_path).to eq(project_path(project))
    title = "TextMate 2 - Projects - Ticketee"
    expect(page).to have_title(title)
  end
end