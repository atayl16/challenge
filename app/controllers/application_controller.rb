class ApplicationController < ActionController::Base
  before_action :authenticate_user!

 before_action :set_global_variables, if: :user_signed_in?
 def set_global_variables
   @ransack_projects = Project.ransack(params[:projects_search], search_key: :projects_search) #navbar search
 end
end
