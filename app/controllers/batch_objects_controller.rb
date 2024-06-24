# frozen_string_literal: true

class BatchObjectsController < ApplicationController
  before_action :set_batch

  def index
    @search_response = SearchBatchObjects.new(search_params,
                                              @batch.id,
                                              current_user.proxy_header).call

    not_found unless @search_response.success?

    @batch_objects = @search_response.batch_objects

    return unless @batch_objects.count.positive?

    # if params[:batch_object_id] is not present, display the first object in the list
    batch_object_id = params[:batch_object_id] || @batch_objects.first.id
    set_batch_object(batch_object_id)
  end

  private

  def set_batch
    @batch = Batch.find(params[:batch_id], current_user.proxy_header)
    current_organization(@batch.org_name)
  # display the Not Found page if the user provides an id that does not exist
  rescue PreservationManagerProxy::BadRequest, PreservationManagerProxy::NotFound
    Rails.logger.error { "BadRequest or NotFound when trying to find batch: #{params[:batch_id]}" }
    not_found
  end

  # rubocop:disable Naming/AccessorMethodName
  def set_batch_object(batch_object_id)
    @batch_object = BatchObject.find(batch_object_id, @batch.id, current_user.proxy_header)
    @events = @batch_object.events(current_user.proxy_header)

    @file_diffs = @batch_object.file_diffs(current_user.proxy_header)
    @files = @batch_object.files(current_user.proxy_header)
  rescue PreservationManagerProxy::BadRequest, PreservationManagerProxy::NotFound
    Rails.logger.error { "BadRequest or NotFound for batch object: #{batch_object_id}" }
    not_found
  end
  # rubocop:enable Naming/AccessorMethodName

  def search_params
    params.except(:batch_id, :batch_object_id, :commit).permit(:page, :has_problems)
  end
end
