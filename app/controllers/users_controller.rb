class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)

    # @pagy, @users = pagy(@q.result(distinct: true).order(created_at: :desc))
    #
    # authorize @users
  end

  def show
    # @courses_teaching = @user.courses
    # @courses_learning = @user.enrollments.includes(:course)
  end

  def edit
    # authorize @user
  end

  def update
    # authorize @user
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
