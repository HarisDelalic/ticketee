require 'rails_helper'

SHOW_PROJECT = 'Show project'.freeze
CREATE_PROJECT = 'Create Project'.freeze
UPDATE_PROJECT = 'Update Project'.freeze
EDIT_PROJECT = 'Edit project'.freeze
DELETE_PROJECT = 'Delete project'.freeze

describe 'Create', type: :feature do

  before(:each) do
    visit root_path
    click_link 'New Project'
  end

  scenario 'can create a project', js: true do
    fill_in 'project_name', with: 'TextMate 2'
    fill_in 'project_description', with: 'A text-editor for OS X'
    click_button CREATE_PROJECT

    expect(page).to have_content('Project has been created.')
    title = "TextMate 2 - Projects - Ticketee"
    expect(page).to have_title(title)
  end

  scenario 'can not create project without a name', js: true do
    fill_in 'project_description', with: 'A text-editor for OS X'
    click_button CREATE_PROJECT

    expect(page).to have_content("You have to fill in name attribute!")
  end
end

describe 'Index and Show', type: :feature do
  scenario 'list all projects', js: true do
    first_project = create :project, name: 'first project name', description: 'first project description'
    second_project = create :project, name: 'second project name', description: 'second project description'
    visit projects_path

    expect(page).to have_content(first_project.name)
    expect(page).to have_content(first_project.description)
    expect(page).to have_content(second_project.name)
    expect(page).to have_content(second_project.description)
  end

  scenario 'title is properly set', js: true do
    project = create :project, name: 'TextMate 2', description: 'A text-editor for OS X'

    visit project_path(project)

    expect(page.current_path).to eq(project_path(project))
    title = "TextMate 2 - Projects - Ticketee"
    expect(page).to have_title(title)
  end

  scenario 'User view created project', js: true do
    project = create :project, name: 'project name', description: 'project description'

    visit projects_path

    expect(page).to have_content(SHOW_PROJECT)

    click_link SHOW_PROJECT

    expect(page.current_path).to eq(project_path(project))
    expect(page).to have_title("project name - Projects - Ticketee")
  end

  describe "Edit project", type: :feature do
    let!(:project) { create :project, name: 'project name', description: 'project description' }

    before(:each) do
      visit projects_path
      click_link EDIT_PROJECT
    end
    scenario "User successfully updates project" do
      expect(page.current_path).to eq(edit_project_path(project))

      fill_in "project_name", with: 'project name updated'

      click_button "Update Project"
      expect(page.current_path).to eq(project_path(project))
      expect(page).to have_content("project name updated")
    end

    scenario "User can\'t update project with blank name", js: true do
      expect(page.current_path).to eq(edit_project_path(project))

      fill_in "project_name", with: ''

      click_button UPDATE_PROJECT
      expect(page).to have_content("You have to fill in name attribute!")
    end
  end

  describe 'Delete project', type: :feature do
    let!(:project) { create :project, name: 'project name' }

    scenario 'User delete project from index page' do
      visit projects_path
      click_link DELETE_PROJECT

      expect(page).to have_content('Project has been deleted.')

      expect(page).to_not have_content('project name')
    end

    scenario 'User delete project from show page' do
      visit projects_path
      click_link SHOW_PROJECT
      click_link DELETE_PROJECT

      expect(page).to have_content('Project has been deleted.')

      expect(page).to_not have_content('project name')
    end
  end
end