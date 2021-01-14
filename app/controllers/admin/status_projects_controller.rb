class Admin::StatusProjectsController < Admin::BasesController
  before_action :load_project
  def update
    project.send "#{params[:status]}!"
    respond_to :js
  end

  attr_reader :project

  private

  def load_project
    @project = Project.find_by id: params[:id]
  end
end
