class Admin::UserProjectsController < Admin::BasesController
  before_action :load_object, only: %i(new create)
  before_action :load_user_project, only: :destroy

  def index; end

  def new; end

  def create
    if @object_type == "project"
      user_ids = params["users_projects_#{@object.id}"].select!(&:present?)
      @object.user_ids = user_ids
    else
      project_ids = params["users_projects_#{@object.id}"].select!(&:present?)
      @object.project_ids = project_ids
    end
    respond_to :js
  end

  def destroy
    @user_project.destroy
    redirect_back fallback_location: root_path
  end

  private

  def load_object
    @object_type = params[:type]
    @object = @object_type == "project" ? Project.find_by(id: params[:object_id]) : User.find_by(id: params[:object_id])
  end

  def load_user_project
    @user_project = UserProject.find_by id: params[:id]
  end
end
