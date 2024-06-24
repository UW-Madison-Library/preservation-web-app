# frozen_string_literal: true

SearchBatchesFailure = Struct.new(:error) do
  def success?
    false
  end
end

SearchBatchesSuccess = Struct.new(:batches, :total_results, :total_pages, :current_page) do
  def success?
    true
  end
end

class SearchBatches
  PAGE_NUMBER_REGEX = /^[0-9]*$/
  ERROR_MESSAGE = 'Invalid batch filter(s) submitted'
  PAGE_SIZE = 10

  def initialize(filter_params, org_name, proxy_header)
    @vaults = filter_params[:vault].present? ? [filter_params[:vault]] : nil
    @states = filter_params[:state].present? ? [filter_params[:state]] : nil
    @page = filter_params[:page].presence
    @org_name = org_name
    @proxy_header = proxy_header
  end

  def call
    unless page_valid? && state_valid?
      Rails.logger.error { "#{ERROR_MESSAGE}: #{@states}, #{@page}" }

      return SearchBatchesFailure.new(ERROR_MESSAGE)
    end

    manager_response = $preservation_manager_proxy.search_batches(manager_opts)

    build_response(manager_response)
  end

  private

  def manager_opts
    opts = { state: @states,
             vault: @vaults,
             org_name: @org_name,
             page_size: PAGE_SIZE,
             page: @page }

    opts.merge(@proxy_header)
  end

  def build_response(manager_response)
    batches = manager_response.batches.map { |batch| Batch.new(batch) }

    SearchBatchesSuccess.new(batches,
                             manager_response.total_results,
                             manager_response.total_pages,
                             manager_response.page)
  end

  def page_valid?
    # nil is an acceptable value for @page and results in a search without a specific page
    @page.nil? || PAGE_NUMBER_REGEX.match?(@page)
  end

  def state_valid?
    # nil is an acceptable value for @states and results in a search for batches of any state
    @states.nil? || Batch::STATES.include?(@states.first)
  end
end
