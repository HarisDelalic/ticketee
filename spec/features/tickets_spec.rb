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