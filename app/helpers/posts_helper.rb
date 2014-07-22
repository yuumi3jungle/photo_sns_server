module PostsHelper
  def popover_data_tag(title, content)
    {class: "img-responsive", data: {toggle: "popover", placement: "auto", trigger: "hover", html: true,
          title: title, content: simple_format(content)}}
  end

  def photo_title(timeline)
    "#{timeline.user.name}さんが#{timeline.created_at.to_s(:short)}に撮影"
  end

  def full_url(path)
    request.protocol + request.host_with_port + path
  end
end
