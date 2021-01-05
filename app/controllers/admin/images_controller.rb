class Admin::ImagesController < Admin::BasesController
  # before_action :load_project, except: %i(new index create)
  before_action :load_new_type, only: :new
  before_action :load_image, only: :show

  def index
    @images = Image.all
  end

  def new
    @project = Project.find_by id: params[:project_id]
    respond_to :js
  end

  def show
    if @image.not_predict?
      image_base64 = Base64.encode64 File.open(ActiveStorage::Blob.service.send(:path_for, @image.background.key)).read
      response = HTTParty.post('http://localhost:5000/api/model', body: {image_base64: image_base64})
      response["data"].each do |location|
        content = location["text"]
        coordinate = location["box"]
        Location.create image_id: @image.id, coordinate: coordinate, content: content
      end
      @image.predicted!
    end
    @locations = @image.locations
  end

  def edit; end 

  def create
    params[:backgrounds].each do |background|
      name = background.original_filename
      base_64 = "data:image/jpeg;base64,#{Base64.encode64(File.open(background, "rb") {|io| io.read})}"
      image = current_user.images.build name: name, project_id: params[:project_id]
      image.background.attach(data: base_64)
      image.save
    end
    redirect_back fallback_location: root_path
  end

  def update
    if @project.update project_params
      flash[:success] = "Update project successfully"
      redirect_to admin_projects_path
    else
      flash.now[:danger] = "Update project failed"
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = "Update project successfully"
    else
      flash[:danger] = "Update project failed"
    end
    redirect_to admin_projects_path
  end

  private

  def project_params
    params.require(:project).permit Project::PROJECTS_PARAMS
  end

  def load_project
    @project = Project.find_by id: params[:id]
    return if @project

    flash[:danger] = t "not_permittion"
    redirect_to root_path
  end

  def load_new_type
    @new_type = params[:new_type]
  end

  def load_image
    @image = Image.find_by id: params[:id]
  end
end
