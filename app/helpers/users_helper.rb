module UsersHelper

  def avatar_image(user)
    hash = Digest::MD5.hexdigest(user.email)
    image_tag("http://www.gravatar.com/avatar/#{hash}", :class => "media-object gravatar", :alt => user.username)
  end

end
