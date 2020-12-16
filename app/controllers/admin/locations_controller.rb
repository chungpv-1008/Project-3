class Admin::LocationsController < Admin::BasesController
  before_action :load_location

  def edit; end

  def update
    @location.update location_params
    redirect_back fallback_location: root_path
  end

  private

  def location_params
    params.require(:location).permit %i(content)
  end

  def load_location
    @location = Location.find_by id: params[:id]
  end
end
