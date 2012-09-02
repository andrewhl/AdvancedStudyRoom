module ApplicationHelper

  def twitterized_type(type)
    case type
      when :alert
        "warning"
      when :notice
        "info"
      else
        type.to_s
    end
  end

  def title
    base_title = "Advanced Study Room"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def sub_title
    "#{@title}"
  end

end
