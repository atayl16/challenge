class HomeController < ApplicationController
 # skip_before_action :authenticate_user!
  def index
    @projects = Project.all.limit(3)
    @latest_projects = Project.all.limit(3).order(created_at: :desc)
    @best_projects = Project.all.limit(3).order(average_rating: :desc)
    @popular_projects = Project.all.limit(3).order(enrollments_count: :desc)
  end
end
