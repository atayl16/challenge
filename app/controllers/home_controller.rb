class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @projects = Project.all.limit(3)
    @latest_projects = Project.latest
    @best_projects = Project.best
    @popular_projects = Project.popular
  end
end
