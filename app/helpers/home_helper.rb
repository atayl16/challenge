module HomeHelper
  def dashboard_button
    if current_user
      link_to 'Go to Dashboard', dashboard_path(current_user), class: 'btn btn-magenta shiny text-white'
    end
  end
end
