class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy like ]
  before_action :set_tags, only: [:index, :accepted, :pending_review, :created, :show, :edit, :update]
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
    @pagy, @projects = pagy(@ransack_projects.result.includes(:user, :project_tags, project_tags: :tag).order(created_at: :desc))
    @tags = Tag.all.where.not(project_tags_count: 0).order(project_tags_count: :desc)
  end

  def accepted
    @ransack_path = accepted_projects_path
    @ransack_projects = Project.joins(:enrollments).where(enrollments: {user: current_user}).ransack(params[:projects_search], search_key: :projects_search)
    @pagy, @projects = pagy(@ransack_projects.result.includes(:user, :project_tags, project_tags: :tag))
    @tags = Tag.all.where.not(project_tags_count: 0).order(project_tags_count: :desc)
    render 'index'
  end

  def pending_review
    @ransack_path = pending_review_projects_path
    @ransack_projects = Project.joins(:enrollments).merge(Enrollment.pending_review.where(user: current_user)).ransack(params[:projects_search], search_key: :projects_search)
    @pagy, @projects = pagy(@ransack_projects.result.includes(:user, :project_tags, project_tags: :tag))
    @tags = Tag.all.where.not(project_tags_count: 0).order(project_tags_count: :desc)
    render 'index'
  end

  def created
    @ransack_path = created_projects_path
    @ransack_projects = Project.where(user: current_user).ransack(params[:projects_search], search_key: :projects_search)
    @pagy, @projects = pagy(@ransack_projects.result.includes(:user, :project_tags, project_tags: :tag))
    @tags = Tag.all.where.not(project_tags_count: 0).order(project_tags_count: :desc)
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
        format.html { redirect_to @project, notice: "You have issued a new challenge." }
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
        format.html { redirect_to @project, notice: "Challenge was successfully updated." }
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
      format.html { redirect_to projects_url, notice: "Challenge was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    def set_tags
      @tags = Tag.all.where.not(project_tags_count: 0).order(project_tags_count: :desc)
    end

    def set_project
      @project = Project.friendly.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :requirements, :content, :user_id, :duration, :avatar, tag_ids: [])
    end
end
