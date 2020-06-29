class Video < ApplicationRecord
  VIDEOS_PARAMS = %i(title description clip thumbnail course_id).freeze

  belongs_to :course
  has_one_attached :clip
  has_one_attached :thumbnail

  validates :course_id, presence: true
  validates :title, presence: true, length: {
      maximum: Settings.video.max_title_length,
      minimum: Settings.video.min_title_length
    }
  validates :description, presence: true

  delegate :user, to: :course

  def next_videos
    course.videos.offset(self.id).limit Settings.video.next_video
  end

  def n_first_videos
    course.videos.first Settings.video.next_video
  end
end
