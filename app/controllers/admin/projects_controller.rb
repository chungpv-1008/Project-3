class Admin::ProjectsController < Admin::BasesController
  before_action :load_project, except: %i(new index create)

  def index
    @projects = Project.all
  end

  def show; end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new project_params
    @project.avatar.attach project_params[:avatar]
    if @project.save
      flash[:success] = "Create project successfully"
      redirect_to admin_projects_path
    else
      flash.now[:danger] = "Create project failed"
      render :new
    end
  end

  def update
    if @project.update project_params
      flash[:success] = "Update project successfully"
      redirect_to admin_projects_path
    else
      flash.now[:danger] = "Update project failed"
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = "Update project successfully"
    else
      flash[:danger] = "Update project failed"
    end
    redirect_to admin_projects_path
  end

  def members
    @members = @project.users
  end

  def images
    @images = @project.images
  end

  private

  def project_params
    params.require(:project).permit Project::PROJECTS_PARAMS
  end

  def load_project
    @project = Project.find_by id: params[:id]
    return if @project

    flash[:danger] = t "not_permittion"
    redirect_to root_path
  end
end
