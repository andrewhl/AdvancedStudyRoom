module ApplicationHelper

  def twitterized_type(type)
    case type
      when :success then "alert-success"
      when :alert then "warning"
      when :notice then "info"
      when :error then "alert-error"
      when :info then "alert-info"
      else
        type.to_s
    end
  end

  def breadcrumbs?
    @show_breadcrumbs
  end

  def active_class_for(route)
    ctrl, action = route.to_s.split('#')
    'active' if ctrl == params[:controller] && (!action || action == params[:action])
  end

  def errors_summary(instance)
    content_tag :div, class: "alert alert-error" do
      content_tag(:h3, "Please fix the following errors:") +
      content_tag(:ul) do
        instance.errors.full_messages.collect do |msg|
          content_tag(:li, msg)
        end.join.html_safe
      end
    end
  end

  def sortable(column, title = nil, *args)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def rank_options_for_select(selected = nil)
    ranks = []
    9.downto(-29).each do |n|
      ranks << [Utilities::format_rank(n), n]
    end
    ranks
  end

  def icon_link_to(url, icon)
    link_to url do
      content_tag :i, "", class: "icon-#{icon}"
    end
  end

end
