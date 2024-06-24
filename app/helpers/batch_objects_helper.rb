# frozen_string_literal: true

module BatchObjectsHelper
  def find_object_file(object_files, diff_file_path)
    object_files.find { |object_file| object_file.path == diff_file_path }
  end

  def analysis_text(errors, warnings)
    if errors
      'Errors Detected'
    elsif warnings
      'Warnings Detected'
    else
      'No errors or warnings were detected.'
    end
  end

  # current_page starts at 0
  def dropdown_range(current_page, total_results)
    page_objects_start = current_page * SearchBatchObjects::PAGE_SIZE

    begin_range = page_objects_start + 1
    end_range = page_objects_start + SearchBatchObjects::PAGE_SIZE

    # the second value in the range should be at most the total results value
    "#{begin_range} - #{[end_range, total_results].min}"
  end

  def previous_page(current_page)
    text = "Previous #{SearchBatchObjects::PAGE_SIZE}"

    if current_page.positive?
      page_params = { page: (current_page - 1), has_problems: params[:has_problems] }

      link_to batch_objects_path(params[:batch_id], params: page_params) do
        previous_page_helper(text, 'pagination__div')
      end
    else
      previous_page_helper(text, ['pagination__div', 'pagination__div--disabled'])
    end
  end

  def next_page(current_page, total_pages)
    text = "Next #{SearchBatchObjects::PAGE_SIZE}"
    next_page = current_page + 1
    if next_page < total_pages
      page_params = { page: next_page, has_problems: params[:has_problems] }

      link_to batch_objects_path(params[:batch_id], params: page_params) do
        next_page_helper(text, 'pagination__div')
      end
    else
      next_page_helper(text, ['pagination__div', 'pagination__div--disabled'])
    end
  end

  # Returns an array that separates file diffs by diff_state for display purposes.
  # Example of returned array if there were four different file diffs with the four different
  # diff_states:
  # [['ADDED', [file_diff1]],
  #  ['MODIFIED', [file_diff2]],
  #  ['REMOVED', [file_diff3]],
  #  ['UNCHANGED', [file_diff4]]]
  def sorted_file_diffs(file_diffs)
    sorted_diffs = {}
    file_diffs.each do |curr_diff|
      sorted_diffs[curr_diff.diff_state] = [] unless sorted_diffs.include?(curr_diff.diff_state)
      sorted_diffs[curr_diff.diff_state] << curr_diff
    end
    # transforms the hash into a sorted array
    sorted_diffs.sort
  end

  private

  def previous_page_helper(text, css_classes)
    content_tag(:div, class: css_classes) do
      concat content_tag(:span, 'navigate_before', class: 'material-icons', aria: { hidden: true })
      concat content_tag(:span, text)
    end
  end

  def next_page_helper(text, css_classes)
    content_tag(:div, class: css_classes) do
      concat content_tag(:span, text)
      concat content_tag(:span, 'navigate_next', class: 'material-icons', aria: { hidden: true })
    end
  end
end
