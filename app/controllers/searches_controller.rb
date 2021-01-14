class SearchesController < ApplicationController
  before_action :authenticate_user!, :check_text_search

  def index
    @q = Course.search_by_name @text_search
    @courses = @q.result
  end

  private

  def check_text_search
    @text = params[:search]
    return if @text.present?

    flash[:danger] = t ".danger"
    redirect_back(fallback_location: root_path)
  end
end