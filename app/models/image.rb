class Image < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true
  has_many :locations
  has_one_base64_attached :background

  enum status_assign: {unassign: 0, assign: 1}
  enum status_stick: {unstick: 0, stick: 1}
  enum predict: {not_predict: 0, predicted: 1}

  validates :name, presence: true
end
