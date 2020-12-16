class Project < ApplicationRecord
  PROJECTS_PARAMS = %i(name avatar).freeze

  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects, source: :user
  has_many :images, dependent: :destroy
  has_one_attached :avatar

  validates :name, presence: true, length: {
      maximum: Settings.course.max_length_name,
      minimum: Settings.course.min_length_name
    }
end
