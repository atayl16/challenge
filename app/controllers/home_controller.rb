class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @projects = Project.all.limit(3)
    @latest_projects = Project.latest
    @best_projects = Project.best
    @popular_projects = Project.popular
    @popular_tags = Tag.all.where.not(project_tags_count: 0).order(project_tags_count: :desc).limit(10)
  end

  def dashboard
    @user = current_user
    @enrollments = Enrollment.all.where(user: current_user).order(created_at: :desc)
    @latest_project = Project.latest.limit(1)
    @best_project = Project.best.limit(1)
    @popular_project = Project.popular.limit(1)
    @created_projects = Project.where(user: current_user).limit(5)
    @project = Project.new
    @tags = Tag.all.where.not(project_tags_count: 0).order(project_tags_count: :desc)
    @popular_tags = Tag.all.where.not(project_tags_count: 0).order(project_tags_count: :desc).limit(10)
  end
end
