module ApplicationHelper
  include Pagy::Frontend

  def user_avatar(user, size=40)
    if user.avatar.attached?
      user.avatar.variant(resize_to_limit: [size, size])
    else
      gravatar_image_url(user.email, size: size)
    end
  end

  def project_avatar(project)
    if project.avatar.attached?
      project.avatar
    else
      image_url("https://cdn.pixabay.com/photo/2018/11/14/07/15/success-3814608_960_720.png")
    end
  end

end
