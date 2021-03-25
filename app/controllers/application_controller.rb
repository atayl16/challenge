class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pagy::Backend

  before_action :set_global_variables, if: :user_signed_in?
  def set_global_variables
   @ransack_projects = Project.ransack(params[:projects_search_i_cont_any], search_key: :projects_search) #navbar search
  end



  private

    def user_not_authorized #pundit
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
    end
end
