# frozen_string_literal: true

module ApplicationHelper
  def display_date(timestamp)
    return nil if timestamp.nil?

    DateTime.parse(timestamp).getlocal.strftime('%F %T %Z')
  end

  def highlight_current(controller_names)
    if controller_names.include?(controller_name)
      'nav_highlighted'
    else
      'nav_regular'
    end
  end

  def event_background_color(event)
    return 'event--failure' if event.failure?

    return 'event--warning' if event.success_with_warning?

    ''
  end

  def event_header_icon(event)
    return display_event_icon('dangerous') if event.failure?

    return display_event_icon('warning') if event.success_with_warning?

    display_event_icon('check_circle_outline')
  end

  def event_style(log_count)
    return 'event__list' if log_count > 1

    ''
  end

  private

  def display_event_icon(icon)
    content_tag(:span, icon, class: %w[material-icons event__icon], aria: { hidden: true })
  end
end
