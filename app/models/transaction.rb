class Transaction < ApplicationRecord
  TRANSACTION_PARAMS = %i(user_id course_id).freeze

  belongs_to :user
  belongs_to :course

  validates :user_id, presence: true
  validates :course_id, presence: true

  scope :find_transaction, (lambda do |user, course|
    where(user_id: user, course_id: course)
  end)
end
