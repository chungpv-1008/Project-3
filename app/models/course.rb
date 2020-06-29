class Course < ApplicationRecord
  COURSES_PARAMS = %i(name description category_id cost image).freeze

  belongs_to :user
  belongs_to :category
  has_one_attached :image
  has_many :videos
  has_many :transactions, dependent: :destroy
  has_many :buyers, through: :transactions, source: :user

  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :name, presence: true, length: {
      maximum: Settings.course.max_length_name,
      minimum: Settings.course.min_length_name
    }
  validates :description, presence: true

  scope :search_by_name, ->(text){ransack name_cont: text}
end
