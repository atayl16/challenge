class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    @pagy, @users = pagy(@q.result(distinct: true).order(created_at: :desc))
  end

  def show
  end

  def edit
    authorize @user
  end

  def dashboard
    if current_user
      @user = current_user
      @enrollments = Enrollment.all.where(user: current_user)
    else
      redirect_to root_path
    end
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to root_path, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, {role_ids: []})
  end
end
