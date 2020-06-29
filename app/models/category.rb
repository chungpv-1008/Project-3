class Category < ApplicationRecord
    CATEGORIES_PARAMS = %i(name).freeze

    has_many :courses
    validates :name, presence: true, length: {
        maximum: Settings.category.max_length_name,
        minimum: Settings.category.min_length_name
      }
end
