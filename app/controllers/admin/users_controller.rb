class Admin::UsersController < Admin::BasesController
  # before_action :load_course, only: %i(edit update show)
  # before_action :load_category, only: :update
  # # before_action :current_user_is_teacher_or_admin, except: :show
  # before_action :current_user_has_permittion, only: %i(edit update destroy)

  def index
    @users = User.except_project_managers
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    if @project.save
      flash[:success] = "Create project successfully"
      redirect_to admin_projects_path
    else
      flash.now[:danger] = "Create project failed"
      render :new
    end
  end

  def update
    params[:course][:image] = project_params[:image].blank? ? @course.image : params[:course][:image]
    if @course.update project_params
      flash[:success] = t ".success"
      redirect_to @course
    else
      flash.now[:danger] = t ".failed"
      render :edit
    end
  end

  private

  def project_params
    params.require(:project).permit Project::PROJECTS_PARAMS
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course

    flash[:danger] = t ".not_found"
    redirect_back fallback_location: root_path
  end

  def load_category
    @category = Category.find_by id: params[:course][:category_id]
    return if @category

    flash[:danger] = t ".not_found_category"
    redirect_back fallback_location: root_path
  end

  def current_user_has_permittion
    return if current_user == @course.user || current_user.admin?

    flash[:danger] = t "not_permittion"
    redirect_to root_path
  end

end
