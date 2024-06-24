# frozen_string_literal: true

module ObjectFilesHelper
  def display_source(source)
    source == 'USER' ? 'User Supplied' : 'System Supplied'
  end
end
