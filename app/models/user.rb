class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  USER_PARAMS_SIGNUP = %i(email name role password password_confirmation).freeze
  USER_PARAMS_UPDATE = %i(email name).freeze
  USER_PARAMS_LOGIN = %i(email password password_confirmation).freeze

  enum role: {member: 0, project_manager: 1}

  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects, source: :project
  has_many :images, dependent: :destroy

  before_save :downcase_email
  # has_many :courses, dependent: :destroy
  # has_many :transactions, dependent: :destroy
  # has_many :purchased_courses, through: :transactions, source: :course

  validates :name, presence: true,
    length: {
      maximum: Settings.user.max_length_username,
      minimum: Settings.user.min_length_username
    },
    format: {with: Settings.user.username_regex}
  validates :email, presence: true,
    length: {maximum: Settings.user.max_length_email},
    format: {with: Settings.user.email_regex},
    uniqueness: {case_sensitive: false}

  scope :except_project_managers, (lambda do
    where.not role: Settings.role.project_manager
  end)

  # def has_view_course? course
  #   Transaction.find_transaction(self, course).present?
  # end

  # def has_view_video? video
  #   Transaction.find_transaction(self, video.course).present?
  # end

  private

  def downcase_email
    email.downcase!
  end
end
