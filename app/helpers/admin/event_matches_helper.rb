module Admin::EventMatchesHelper

  def link_to_order(label, column)
    dir = :asc
    is_current = @pag[:order] == column.to_s
    current_dir = @pag[:order_dir]
    dir = :desc if is_current &&
                   (current_dir.blank? || current_dir.to_s =~ /asc/i)
    icon = "<i class='icon-sort-#{dir == :asc ? 'down' : 'up'}'></i>" if is_current
    link_to "#{label} #{icon}".html_safe, params.merge({order: column, order_dir: dir})
  end

  def style_handle(registration, winner_id)
    handle = registration.handle
    if registration.id == winner_id
      "<strong>#{handle}</strong>".html_safe
    else
      handle
    end
  end

end