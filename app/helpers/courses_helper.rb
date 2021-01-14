module CoursesHelper
  def display_course_image course
    course.image
  end

  def display_video_thumbnail video
    video.thumbnail
  end

  def display_video_clip video
    url_for video.clip
  end

  def recent_course count
    Course.last count
  end

  def next_videos video
    return video.n_first_videos if video.next_videos.blank?
  
    video.next_videos
  end

  def index_video video
    video.course.videos.map(&:id).index(video.id) + 1
  end
end
