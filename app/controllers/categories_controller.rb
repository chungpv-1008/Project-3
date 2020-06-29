class CategoriesController < ApplicationController
  before_action :authenticate_user!, :current_user_is_admin
  before_action :load_category, only: %i(edit update show)
  before_action :current_user_is_admin, except: :show

  def new
    @category = Category.new
  end

  def show
    @courses = @category.courses
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t ".success"
      redirect_to new_category_path
    else
      flash.now[:danger] = t ".failed"
      render :new
    end
  end

  def update
    if @category.update category_params
      flash[:success] = t ".success"
      redirect_to @category
    else
      flash.now[:danger] = t ".failed"
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit Category::CATEGORIES_PARAMS
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:success] = t ".not_found"
    redirect_back fallback_location: root_path
  end
end
