class Admin::LocationsController < Admin::BasesController
  before_action :load_location

  def index
    case true
    when params[:image_id].present?
      image = Image.find_by id: params[:image_id]
      @locations = image.locations
      locations_info = locations_info @locations
      json_data = {"form": locations_info}
      @file_name = image.name
    when params[:project_id].present?
      @locations = Location.filter_by_project params[:project_id]
      json_data = {"project" => Array.new}
      Project.find_by(id: params[:project_id]).images.each do |image|
        json_data["project"] << {"form": locations_info(image.locations)}
      end
      @file_name = Project.find_by(id: params[:project_id]).name
    else
      @locations = Location.all
      json_data = {"system" => Array.new}
      Project.all.select(&:unlock_?).each do |project|
        hash = {"project" => Array.new}
        project.images.each do |image|
          hash["project"] << {"form": locations_info(image.locations)}
        end
        json_data["system"] << hash
      end
      @file_name = "System"
    end
    
    respond_to do |format|
      format.html
      format.json do
        send_data JSON.pretty_generate(json_data), filename: @file_name
      end
      format.csv do
        send_data @locations.to_csv, filename: @file_name
      end
    end
  end

  def edit
    coordinate = @location.coordinate
    coordinates = coordinate.split(",").map(&:to_i)
    @left = coordinates[0] > coordinates[2] ? coordinates[2] : coordinates[0]
    @top = coordinates[1] > coordinates[3] ? coordinates[1] : coordinates[3]
    # binding.pry
  end

  def update
    @location.update location_params
    # redirect_back fallback_location: root_path
  end

  private

  def location_params
    params.require(:location).permit %i(content)
  end

  def load_location
    @location = Location.find_by id: params[:id]
  end

  def locations_info locations
    locations.map do |l|
      {box: l.coordinate.split(",").map(&:to_i), text: l.content}
    end
  end
end
