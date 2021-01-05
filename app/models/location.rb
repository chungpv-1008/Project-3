require 'csv'
class Location < ApplicationRecord
  belongs_to :image

  scope :filter_by_project, (lambda do |project_id|
    joins(:image)
    .where(images: {project_id: project_id})
  end)

  scope :filter_by_user, (lambda do |user|
    filter_by_project user.project_ids
  end)

  def self.to_csv
    attributes = %w{id project_id image_id x_min y_min x_max y_max text}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |location|
        csv << attributes.map{ |attr| location.send attr }
      end
    end
  end

  def coordinates
    coordinate.split(",").each(&:to_i)
  end

  def x_min
    coordinates[0]
  end

  def y_min
    coordinates[1]
  end

  def x_max
    coordinates[2]
  end

  def y_max
    coordinates[3]
  end

  def text
    content
  end

  def project_id
    image.project_id
  end
end
