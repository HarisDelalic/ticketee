require 'rails_helper'

SHOW_TICKET = 'Show ticket'.freeze
CREATE_TICKET = 'Create Ticket'.freeze
UPDATE_TICKET = 'Update Ticket'.freeze
EDIT_TICKET = 'Edit ticket'.freeze
DELETE_TICKET = 'Delete ticket'.freeze

RSpec.describe 'create', type: :feature do
  before(:each) do
    visit project_path(project)
    click_link CREATE_TICKET
  end

  let(:project) { create (:project) }

  scenario 'should successfully create a ticket' do
    fill_in 'ticket_name', with: 'Ticket name'
    fill_in 'ticket_description', with: 'Ticket description'

    click_button CREATE_TICKET
    expect(page).to have_content('Ticket has been created.')
    expect(page).to have_content('Ticket name')
    expect(page).to have_content('Ticket description')
  end

  scenario 'should not create ticket without name or description' do
    fill_in 'ticket_name', with: ''
    fill_in 'ticket_description', with: 'Ticket description'

    click_button CREATE_TICKET
    expect(page).to have_content('Ticket has not been created.')
    expect(page.current_path).to eq(project_tickets_path(project))
  end
end

feature 'view', type: :feature  do

  scenario "Viewing tickets for a given project", js: true do
    first_project = create(:project, name: 'TextMate 2', description: 'desc')
    frist_project_ticket = create(:ticket, project: first_project, name: "Make it shiny!", description: "Gradients! Starbursts! Oh my!")
    second_project = create(:project, name: 'Internet Explorer')
    second_project_ticket = create(:ticket, project: second_project, name: "Standards compliance", description: "Isn't a joke.")

    visit projects_path

    click_link "Show project TextMate 2"
    expect(page).to have_content("Make it shiny!")
    expect(page).to_not have_content("Standards compliance")

    click_link "Make it shiny!"
    within("#ticket h2") do
      expect(page).to have_content("Make it shiny!")
    end
    expect(page).to have_content("Gradients! Starbursts! Oh my!")
  end
end