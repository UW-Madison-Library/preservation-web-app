# frozen_string_literal: true

module PreservationObjectsHelper
  def highlight_current_version(current_version, version)
    current_version == version ? 'versions__item--highlight' : ''
  end

  def check_date(timestamp)
    return 'Unavailable until the next scheduled check runs.' if timestamp.nil?

    display_date(timestamp)
  end
end
