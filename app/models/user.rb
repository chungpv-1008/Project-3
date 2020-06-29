class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  USER_PARAMS_SIGNUP = %i(email username role password password_confirmation).freeze
  USER_PARAMS_UPDATE = %i(email username).freeze
  USER_PARAMS_LOGIN = %i(email password password_confirmation).freeze

  enum role: {normal: 0, teacher: 1, admin: 2}
  before_save :downcase_email
  has_many :courses, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :purchased_courses, through: :transactions, source: :course

  validates :username, presence: true,
    length: {
      maximum: Settings.user.max_length_username,
      minimum: Settings.user.min_length_username
    },
    format: {with: Settings.user.username_regex}
  validates :email, presence: true,
    length: {maximum: Settings.user.max_length_email},
    format: {with: Settings.user.email_regex},
    uniqueness: {case_sensitive: false}

  def has_view_course? course
    Transaction.find_transaction(self, course).present?
  end

  def has_view_video? video
    Transaction.find_transaction(self, video.course).present?
  end

  private

  def downcase_email
    email.downcase!
  end
end
