class VideosController < ApplicationController
  before_action :authenticate_user!, :load_course
  before_action :load_video, :has_permittion_view, only: %i(edit update show)
  before_action :current_user_is_teacher_or_admin, only: %i(new create)
  before_action :current_user_has_permittion, only: %i(edit update destroy)

  def new
    @video = @course.videos.build
  end

  def edit; end

  def create
    @video = @course.videos.build videos_params
    if @video.save
      flash[:success] = t ".success"
      redirect_to @course
    else
      flash.now[:danger] = t ".failed"
      render :new
    end
  end

  def update
    params[:video][:thumbnail] = videos_params[:thumbnail].blank? ? @video.thumbnail : params[:video][:thumbnail]
    params[:video][:clip] = videos_params[:clip].blank? ? @video.clip : params[:video][:clip]
    if @video.update videos_params
      flash[:success] = t ".success"
      redirect_to course_video_path(@video.id)
    else
      flash.now[:danger] = t ".failed"
      render :edit
    end
  end

  def show; end

  private

  def videos_params
    params.require(:video).permit Video::VIDEOS_PARAMS
  end

  def load_course
    @course = if request.post?
                Course.find_by id: params[:video][:course_id]
              else
                Course.find_by id: params[:course_id]
              end
    return if @course

    flash[:danger] = t ".not_found_course"
    redirect_to root_path
  end

  def load_video
    @video = Video.find_by id: params[:id]
    return if @video && @video.course == @course

    flash[:danger] = t ".not_found_video"
    redirect_to root_path
  end

  def current_user_has_permittion
    return if current_user == @video.user || current_user.admin?

    flash[:danger] = t "not_permittion"
    redirect_to root_path
  end

  def has_permittion_view
    return if current_user == @video.user || current_user.admin? || current_user.has_view_video?(@video)

    flash[:danger] = t "not_permittion"
    redirect_back fallback_location: root_path
  end
end
