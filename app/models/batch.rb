# frozen_string_literal: true

class Batch
  include ActiveModel::Model

  attr_reader :id, :org_name, :vault, :created_by, :reviewed_by, :state, :original_filename,
              :file_size, :received, :updated

  REVIEW_STATES = [PreservationManager::IngestBatchState::RECEIVED,
                   PreservationManager::IngestBatchState::ANALYZING,
                   PreservationManager::IngestBatchState::PENDING_REVIEW].freeze

  FAILURE_STATES = [PreservationManager::IngestBatchState::ANALYSIS_FAILED,
                    PreservationManager::IngestBatchState::INGEST_FAILED,
                    PreservationManager::IngestBatchState::REPLICATION_FAILED].freeze

  STATES = PreservationManager::IngestBatchState.constants.map(&:to_s)

  def initialize(batch)
    @id = batch[:ingestId]
    @org_name = batch[:orgName]
    @vault = batch[:vault]
    @created_by = batch[:createdBy]
    @reviewed_by = batch[:reviewedBy]
    @state = batch[:state]
    @original_filename = batch[:originalFilename]
    @file_size = batch[:fileSize]
    @received = batch[:receivedTimestamp]
    @updated = batch[:updatedTimestamp]
  end

  def pending_review?
    state == PreservationManager::IngestBatchState::PENDING_REVIEW
  end

  def review_required?
    REVIEW_STATES.include?(state)
  end

  def failure?
    FAILURE_STATES.include?(state)
  end

  def reviewed?
    reviewed_by.present?
  end

  # rubocop:disable Metrics/MethodLength
  def submit_review(review, proxy_header)
    return false unless %w[approve reject].include?(review)

    opts = { body: PreservationManager::ApproveIngestBatchRequest.new({ ingest_id: id }) }

    if review == 'approve'
      $preservation_manager_proxy.approve_ingest_batch(opts.merge(proxy_header))
    else
      $preservation_manager_proxy.reject_ingest_batch(opts.merge(proxy_header))
    end
    true
  rescue PreservationManagerProxy::BadRequest
    Rails.logger.error { "BadRequest after submitting review for batch: #{id}" }
    false
  end
  # rubocop:enable Metrics/MethodLength

  def events(proxy_header)
    events = $preservation_manager_proxy.retrieve_batch_events(id, proxy_header).events

    events.map do |event|
      Event.new(event)
    end
  end

  def self.find(id, proxy_header)
    batch = $preservation_manager_proxy.retrieve_batch(id, proxy_header).ingest_batch

    Batch.new(batch)
  end
end
