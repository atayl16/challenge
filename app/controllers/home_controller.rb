class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @projects = Project.all.limit(3)
    @latest_projects = Project.latest
    @best_projects = Project.best
    @popular_projects = Project.popular
    @popular_tags = Tag.all.where.not(project_tags_count: 0).order(project_tags_count: :desc).limit(10)
  end
end
