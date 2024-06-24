# frozen_string_literal: true

SearchBatchObjectsFailure = Struct.new(:error) do
  def success?
    false
  end
end

SearchBatchObjectsSuccess =
  Struct.new(:batch_objects, :total_results, :total_pages, :current_page) do
    def success?
      true
    end
  end

class SearchBatchObjects
  FILTERS = { any: nil, warning: 'WARNINGS', error: 'ERRORS', no_issues: 'NONE' }.freeze
  PAGE_NUMBER_REGEX = /^[0-9]*$/
  ERROR_MESSAGE = 'Invalid batch object filter(s) submitted'
  PAGE_SIZE = 10

  def initialize(filter_params, batch_id, proxy_header)
    @batch_id = batch_id
    @problem = filter_params[:has_problems].presence
    @page = filter_params[:page].presence
    @proxy_header = proxy_header
  end

  def call
    unless page_valid? && problem_valid?
      Rails.logger.error { "#{ERROR_MESSAGE}: #{@problem}, #{@page}" }
      return SearchBatchObjectsFailure.new(ERROR_MESSAGE)
    end

    manager_response = $preservation_manager_proxy.retrieve_batch_objects(@batch_id, options)

    build_response(manager_response)
  end

  private

  def options
    opts = { has_problems: @problem,
             page_size: PAGE_SIZE,
             page: @page }

    opts.merge(@proxy_header)
  end

  def build_response(manager_response)
    batch_objects = manager_response.batch_objects.map { |object| BatchObject.new(object) }

    SearchBatchObjectsSuccess.new(batch_objects,
                                  manager_response.total_results,
                                  manager_response.total_pages,
                                  manager_response.page)
  end

  def page_valid?
    @page.nil? || PAGE_NUMBER_REGEX.match?(@page)
  end

  def problem_valid?
    FILTERS.values.include?(@problem)
  end
end
