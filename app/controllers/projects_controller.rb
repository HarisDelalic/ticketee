class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = 'Project has been created.'
      redirect_to @project
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project has been updated"
      redirect_to @project
    else
      render :edit
    end
  end

  def show
  end

  def edit
  end

  def destroy
    if @project.destroy
      flash[:notice] = 'Project has been deleted.'
      redirect_to projects_path
    else
      flash[:notice] = 'Project has not been deleted.'
    end
  end

  private
  def set_project
    @project = Project.find(params[:id])
  rescue
    flash[:alert] = 'Project can not be found.'
    redirect_to projects_path
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
