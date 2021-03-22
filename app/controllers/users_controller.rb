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
    @user = current_user
    @enrollments = Enrollment.all.where(user: current_user)
    @latest_project = Project.latest.limit(1)
    @best_project = Project.best.limit(1)
    @popular_project = Project.popular.limit(1)
    @created_projects = Project.where(user: current_user).limit(5)
    @project = Project.new
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
