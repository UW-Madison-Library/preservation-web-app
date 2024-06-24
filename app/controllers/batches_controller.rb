# frozen_string_literal: true

class BatchesController < ApplicationController
  before_action :set_batch, only: %i[show edit update]

  def index
    @search_response = SearchBatches.new(search_params,
                                         current_organization.name,
                                         current_user.proxy_header).call

    # Displays not_found if the user mistypes the state in the address
    not_found unless @search_response.success?

    @vaults = Vault.all(current_organization.name, current_user.proxy_header)
  end

  def show
    @events = @batch.events(current_user.proxy_header)

    search_objects
    analyze_batch
  end

  def new
    @batch = Batch.new({})
    @vaults = Vault.all_write_access(current_organization.name, current_user.proxy_header)
  end

  def edit
    flash_status_alert unless @batch.pending_review?

    # Allow the user to keep refreshing the edit page if the state is ANALYZING or RECEIVED
    # Only redirect if the user will not have the option to review the batch
    redirect_to batch_path unless @batch.review_required?

    return unless @batch.pending_review?

    @events = @batch.events(current_user.proxy_header)
    @vault = Vault.find(@batch.vault, current_user.proxy_header)

    search_objects
    analyze_batch
  end

  # A batch is created when the Preservation Manager ingests a BagIt Bag
  def create
    bag_ingest = IngestBag.new(batch_params, current_user.proxy_header).call

    if bag_ingest.success?
      redirect_to edit_batch_path(bag_ingest.batch_id)
    else
      redirect_to new_organization_batch_path, alert: bag_ingest.error
    end
  end

  def update
    if @batch.submit_review(params[:review], current_user.proxy_header)
      redirect_to batch_path
    else
      redirect_to edit_batch_path
    end
  end

  private

  def flash_status_alert
    if @batch.review_required?
      flash.now[:notice] =
        'Analyzing the batch may take a few minutes. Please refresh the page for updates.'
    else
      flash[:alert] =
        "Only batches with a status of 'Pending Review' may be accepted or rejected."
    end
  end

  def search_objects
    @total_object_count = search_objects_helper(SearchBatchObjects::FILTERS[:any])
    @warning_object_count = search_objects_helper(SearchBatchObjects::FILTERS[:warning])
    @error_object_count = search_objects_helper(SearchBatchObjects::FILTERS[:error])
    @no_issues_object_count = search_objects_helper(SearchBatchObjects::FILTERS[:no_issues])
  end

  def analyze_batch
    batch_analysis = AnalyzeBatch.new(@warning_object_count,
                                      @error_object_count,
                                      @events,
                                      @batch).call

    @analysis = batch_analysis.success? ? batch_analysis.message : nil
  end

  def search_objects_helper(filter)
    SearchBatchObjects.new({ has_problems: filter }, @batch.id, current_user.proxy_header)
                      .call
                      .total_results
  end

  def set_batch
    @batch = Batch.find(params[:id], current_user.proxy_header)
    current_organization(@batch.org_name)
  # display the Not Found page if the user provides an id that does not exist
  rescue PreservationManagerProxy::BadRequest, PreservationManagerProxy::NotFound
    Rails.logger.error { "BadRequest or NotFound after attempt to find batch id: #{params[:id]}" }
    not_found
  end

  # Only allow a list of trusted parameters through
  def batch_params
    params.fetch(:batch, {}).permit(:bag, :vault)
  end

  def search_params
    params.except(:commit, :organization_id).permit(:vault, :state, :page)
  end
end
