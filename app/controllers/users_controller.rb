class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show ]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    @pagy, @users = pagy(@q.result(distinct: true).order(created_at: :desc))
    @popular_tags = Tag.all.where.not(project_tags_count: 0).order(project_tags_count: :desc).limit(10)
  end

  def show
    @enrollments = Enrollment.where(user: @user).all

  end

  def edit
    authorize @user
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
    params.require(:user).permit(:name, :avatar, {role_ids: []})
  end
end
