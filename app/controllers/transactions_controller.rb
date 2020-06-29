class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, :load_course, only: :create

  def new
    @transaction = current_user.transaction
  end

  def create
    @transaction = current_user.transactions.build course: @course
    unless @transaction.save
      @message = "Không mua khóa học này"
    end
    respond_to :js
  end

  private

  def transactions_params
    params.require(:transaction).permit Transaction::TRANSACTION_PARAMS
  end

  def load_user
    @user = User.find_by id: transactions_params[:user_id]
    return if @user == current_user

    flash[:danger] = t ".not_permittion"
    redirect_back fallback_location: root_path
  end

  def load_course
    @course = Course.find_by id: transactions_params[:course_id]
    return if @course && current_user != @course.user

    flash[:danger] = t ".not_permittion"
    redirect_back fallback_location: root_path
  end
end
