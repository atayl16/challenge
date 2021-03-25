module EnrollmentsHelper
  def complete_button(enrollment)
    if enrollment.complete?
      link_to 'Set to Incomplete', uncomplete_enrollment_path(enrollment), method: :patch, class: 'btn btn-danger'
    else
      link_to 'Mark as Complete', complete_enrollment_path(enrollment), method: :patch, class: 'btn btn-success'
    end
  end
end
