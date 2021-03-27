module ProjectsHelper
  def enrollment_button(project)
    if current_user
      if !project.enrollments.where(user: current_user).any?
        form_tag project_enrollments_path(project) do
         submit_tag "Join", class: 'btn shiny btn-palegreen'
        end
      else
        link_to 'Leave Challenge', enrollment_path(project.enrollments.where(user: current_user).first), class: 'btn shiny btn-palegreen', method: :delete, data: { confirm: 'Are you sure you want to leave this challenge?' }
      end
    end
  end

  def like_button(project)
    if current_user
      if current_user.liked? project
        link_to "Unlike", like_project_path(project, "unlike"), class: "liked-btn btn shiny btn-maroon text-white", method: :put, remote: :true
      else
        link_to "Like", like_project_path(project, "like"), class: "like-btn btn shiny btn-maroon text-white", method: :put, remote: :true
      end
    end
  end

  def edit_project_button(project)
    if current_user
      if project.user == current_user
        button_to 'Edit', edit_project_path(project), method: :get, :class => "btn shiny btn-palegreen"
      end
    end
  end

  def delete_project_button(project)
    if current_user
      if project.user == current_user
        button_to 'Delete', project, method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-magenta text-white shiny'
      end
    end
  end

  def review_button(project)
    user_project = project.enrollments.where(user: current_user)
    if current_user
      if user_project.any?
        if user_project.pending_review.any?
          button_to 'Rate Challenge', edit_enrollment_path(user_project.first), method: :get,  :class => 'btn btn-blue shiny text-white'
        else
          button_to 'Change Rating', edit_enrollment_path(user_project.first), method: :get, :class => 'btn btn-blue shiny text-white'
        end
      end
    end
  end
end
