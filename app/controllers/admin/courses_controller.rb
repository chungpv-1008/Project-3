class Admin::CoursesController < Admin::BasesController
  before_action :load_course, only: %i(edit update show)
  before_action :load_category, only: :update
  before_action :current_user_is_teacher_or_admin, except: :show
  before_action :current_user_has_permittion, only: %i(edit update destroy)

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build course_params
    @course.image.attach course_params[:image]
    if @course.save
      flash[:success] = t ".success"
      redirect_to courses_path
    else
      flash.now[:danger] = t ".failed"
      render :new
    end
  end

  def update
    params[:course][:image] = course_params[:image].blank? ? @course.image : params[:course][:image]
    if @course.update course_params
      flash[:success] = t ".success"
      redirect_to @course
    else
      flash.now[:danger] = t ".failed"
      render :edit
    end
  end

  private

  def course_params
    params.require(:course).permit Course::COURSES_PARAMS
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
