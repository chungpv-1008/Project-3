class ProjectsController < ApplicationController
  before_action :load_project, only: %i(show images)

  def index
    @projects = current_user.projects
  end

  def show; end

  def images
    @images = @project.images
  end

  private

  def load_project
    @project = Project.find_by id: params[:id]
  end
end
