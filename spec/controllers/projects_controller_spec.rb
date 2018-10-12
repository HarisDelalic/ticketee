require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET #show' do
    it 'when project does not exists redirect to index with error message' do
      get :show, params: { id: 'not_exist' }
      expect(response).to redirect_to(projects_path)
      message = "Project can not be found."
      expect(flash[:alert]).to eq(message)
    end
    it 'assigns the requested project as @project' do
      project = create(:project)

      get :show, params: { id: project.id }

      expect(assigns(:project)).to eq(project)
    end
  end
end