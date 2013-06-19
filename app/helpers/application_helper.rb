module ApplicationHelper

  def pages
    pages = []
    Page.all.each do |page|
      pages << {title: page.title, path: page.path}
    end
    pages
  end

  def twitterized_type(type)
    case type
      when :success then "alert-success"
      when :notice  then "info"
      when :alert   then "alert-warning"
      when :error   then "alert-error"
      when :info    then "alert-info"
      else
        type.to_s
    end
  end

  def alert(type = :info, options = {}, &block)
    opts = options.merge(class: "alert #{twitterized_type(type)} clearfix")
    opts[:class] += " #{options[:class]}"
    content_tag(:div, opts) do
      capture_haml(&block)
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
        instance.errors.full_messages.uniq.collect do |msg|
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

  def division_sortable(column, title = nil, division_id = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :division_id => division_id}, {:class => css_class}
  end

  def rank_display(rank)
    rank.presence || 'Pending...'
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

  def yes_no(value)
    value ? 'Yes' : 'No'
  end


  class TableSorter

    attr_accessor :direction, :column

    def initialize(args)
      @direction = args[:direction] || "desc"
      @column    = args[:column]    || "id"
      @table     = args[:table].constantize
    end

    def sortable(args)
      column           = args[:column]
      scope_table      = args[:scope_table] || nil
      @direction       = args[:params][:direction]
      scope_table_name = paramaterize(scope_table) || "scope_table"

      {:sort => column, :direction => check_direction, :"#{scope_table_name}" => scope_table, :class => css_class(column)}
    end

    def sort_column
      @table.column_names.include?(@column) ? @column : "id"
    end

    def sort_direction
      %w[asc desc].include?(@direction) ? @direction : "desc"
    end

    private

      def paramaterize(table)
        table.class.name.downcase
      end

      def css_class(column)
        column == sort_column ? "current #{sort_direction}" : nil
      end

      def check_direction
        sort_direction == "asc" ? "desc" : "asc"
      end
  end

end
