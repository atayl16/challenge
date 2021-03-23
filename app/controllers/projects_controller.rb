class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy like ]
  respond_to :js, :html, :json

  def like
    if params[:format] == 'like'
      @project.liked_by current_user
      redirect_to request.referrer
    elsif params[:format] == 'unlike'
      @project.unliked_by current_user
      redirect_to request.referrer
    end
  end

  def index
    @ransack_path = projects_path
    @ransack_projects = Project.ransack(params[:projects_search], search_key: :projects_search)
    @pagy, @projects = pagy(@ransack_projects.result.includes(:user).order(created_at: :desc))
  end

  def accepted
    @ransack_path = accepted_projects_path
    @ransack_projects = Project.joins(:enrollments).where(enrollments: {user: current_user}).ransack(params[:projects_search], search_key: :projects_search)
    @pagy, @projects = pagy(@ransack_projects.result.includes(:user))
    render 'index'
  end

  def pending_review
    @ransack_path = pending_review_projects_path
    @ransack_projects = Project.joins(:enrollments).merge(Enrollment.pending_review.where(user: current_user)).ransack(params[:projects_search], search_key: :projects_search)
    @pagy, @projects = pagy(@ransack_projects.result.includes(:user))
    render 'index'
  end

  def created
    @ransack_path = created_projects_path
    @ransack_projects = Project.where(user: current_user).ransack(params[:projects_search], search_key: :projects_search)
    @pagy, @projects = pagy(@ransack_projects.result.includes(:user))
    render 'index'
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @project
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.friendly.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :content, :user_id, :duration)
    end
end
