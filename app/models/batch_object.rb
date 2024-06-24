# frozen_string_literal: true

class BatchObject
  include ActiveModel::Model

  attr_reader :id, :batch_id, :state, :reviewed_by, :errors, :warnings, :vault,
              :preservation_object_version

  DISPLAY_STATES = {
    PreservationManager::IngestObjectState::ANALYZING => 'Analyzing',
    PreservationManager::IngestObjectState::ANALYSIS_FAILED => 'Analysis Failed',
    PreservationManager::IngestObjectState::PENDING_REVIEW => 'Pending Review',
    PreservationManager::IngestObjectState::PENDING_INGESTION => 'Pending Ingestion',
    PreservationManager::IngestObjectState::PENDING_REJECTION => 'Pending Rejection',
    PreservationManager::IngestObjectState::INGESTING => 'Ingesting',
    PreservationManager::IngestObjectState::INGESTED => 'Ingested',
    PreservationManager::IngestObjectState::INGEST_FAILED => 'Ingest Failed',
    PreservationManager::IngestObjectState::NO_CHANGE => 'No Change',
    PreservationManager::IngestObjectState::REPLICATING => 'Replicating',
    PreservationManager::IngestObjectState::REPLICATED => 'Replicated',
    PreservationManager::IngestObjectState::REPLICATION_FAILED => 'Replication Failed',
    PreservationManager::IngestObjectState::COMPLETE => 'Ingest Complete',
    PreservationManager::IngestObjectState::REJECTING => 'Rejecting',
    PreservationManager::IngestObjectState::REJECTED => 'Rejected'
  }.freeze

  def initialize(batch_object)
    @id = batch_object[:externalObjectId]
    @batch_id = batch_object[:ingestId]
    @state = batch_object[:state]
    @reviewed_by = batch_object[:reviewedBy]
    @errors = batch_object[:hasAnalysisErrors]
    @warnings = batch_object[:hasAnalysisWarnings]
    @vault = batch_object[:vault]
    @preservation_object_version = batch_object[:version]
  end

  def self.find(id, batch_id, proxy_header)
    batch_object = $preservation_manager_proxy.retrieve_batch_object(batch_id, id, proxy_header)
                                              .batch_object

    BatchObject.new(batch_object)
  end

  def events(proxy_header)
    events = $preservation_manager_proxy.retrieve_batch_object_events(batch_id, id, proxy_header)
                                        .events

    events.map { |event| Event.new(event) }
  end

  def files(proxy_header)
    return [] if analysis_failed?

    files = $preservation_manager_proxy.retrieve_batch_object_files(batch_id, id, proxy_header)
                                       .files

    files.map { |file| ObjectFile.new(file) }
  end

  # diff_batch_object is not available for objects that fail analysis
  def file_diffs(proxy_header)
    return [] if analysis_failed?

    file_diffs = $preservation_manager_proxy.diff_batch_object(batch_id, id, proxy_header).files

    file_diffs.map { |file_diff| ObjectFileDiff.new(file_diff) }
  end

  def analysis_failed?
    state == PreservationManager::IngestObjectState::ANALYSIS_FAILED
  end

  def version_ingested?
    preservation_object_version.present? &&
      (state != PreservationManager::IngestObjectState::INGESTING)
  end
end
