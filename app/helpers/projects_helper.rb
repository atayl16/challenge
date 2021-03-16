module ProjectsHelper
  def enrollment_button(project)
    if current_user
      if project.enrollments.where(user: current_user).any?
        link_to "Continue", project_path(project), class: 'btn btn-info shiny'
      else
        link_to "Join", new_project_enrollment_path(project), class: 'btn btn-info text-white shiny'
      end
    end
  end

  def review_button(project)
    user_project = project.enrollments.where(user: current_user)
    if current_user
      if user_project.any?
        if user_project.pending_review.any?
          link_to 'Add a review', edit_enrollment_path(user_project.first), class: 'btn btn-blue shiny text-white'
        else
          link_to 'Thanks for reviewing!', enrollment_path(user_project.first)
        end
      end
    end
  end
end
