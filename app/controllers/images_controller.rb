class ImagesController < ApplicationController
  before_action :load_image, only: :update

  def update
    @image.locations.each(&:destroy)
  end

  private

  def load_image
    @image = Image.find_by id: params[:image_id]
  end
end
