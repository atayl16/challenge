module ProjectsHelper
  def enrollment_button(project)
    if current_user
      if project.enrollments.where(user: current_user).any?
        link_to "Continue", project_path(project), class: 'btn btn-info shiny'
      else
        link_to "Join", new_project_enrollment_path(project), class: 'btn btn-success shiny'
      end
    end
  end
end
