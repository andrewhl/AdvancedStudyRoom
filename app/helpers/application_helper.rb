module ApplicationHelper

  def twitterized_type(type)
    case type
      when :success then "alert-success"
      when :notice  then "info"
      when :alert   then "warning"
      when :error   then "alert-error"
      when :info    then "alert-info"
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
    link_to title, {:sort => column, :direction => direction, :"#{args[0]}_id" => }, {:class => css_class}
  end

  def division_sortable(column, title = nil, division_id = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :division_id => division_id}, {:class => css_class}
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


  class TableSorter
    def initialize(args)
      @sort_direction = args[:sort_direction] || "asc"
      @sort_column    = args[:sort_column]    || "id"
      @table          = arsg[:table].constantize
    end

    def sortable(args)
      column           = args[:column]
      title            = args[:title] || nil
      scope_table      = args[:scope_table] || nil
      scope_table_name = paramaterize(scope_table) || "scope_table"

      title ||= column.titleize
      link_to title, {:sort => column, :direction => direction, :"#{scope_table_name}" => scope_table}, {:class => css_class(column)}
    end

    def sort_column
      @table.column_names.include?(params[:sort]) ? params[:sort] : @sort_column
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : @sort_direction
    end

    private
      def paramaterize(table)
        table.class.name.downcase
      end

      def css_class(column)
        column == sort_column ? "current #{sort_direction}" : nil
      end

      def direction
        sort_direction == "asc" ? "desc" : "asc"
      end
  end

end
