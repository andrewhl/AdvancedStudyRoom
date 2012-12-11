module ApplicationHelper

  def twitterized_type(type)
    case type
      when :success
        "alert-success"
      when :alert
        "warning"
      when :notice
        "info"
      when :error
        "alert-error"
      when :info
        "alert-info"
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

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'current' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

end
