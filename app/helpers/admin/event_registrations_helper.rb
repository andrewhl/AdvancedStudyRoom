module Admin::EventRegistrationsHelper

  def division_options(current_division = nil)
    options = ''
    div_id = current_division.kind_of?(Division) ? current_division.id : current_division.to_i
    @event.divisions.each do |div|
      disabled = div.id == div_id ? 'disabled="disabled"' : ''
      options << "<option #{disabled} value='#{div.id}'>#{div.display_name}</option>"
    end

    disabled = div_id == 0 ? 'disabled="disabled"' : ''
    options << "<option #{disabled} value='-1'>-- Unassign --</option>"
    options << "<option #{disabled} value='-2'>-- Quit Event --</option>"
    options.html_safe
  end

end