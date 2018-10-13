class AddProjectReferenceToTickets < ActiveRecord::Migration[5.1]
  def change
    add_reference :tickets, :project, index: true
  end
end
