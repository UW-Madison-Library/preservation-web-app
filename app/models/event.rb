# frozen_string_literal: true

class Event
  attr_reader :type, :outcome, :timestamp, :username, :logs

  EVENT_TYPES = {
    PreservationManager::EventType::RECEIVE_BAG => 'Receive Bag',
    PreservationManager::EventType::VIRUS_SCAN_BAG => 'Virus Scan Bag',
    PreservationManager::EventType::VALIDATE_BAG => 'Validate Bag',
    PreservationManager::EventType::IDENTIFY_OBJ => 'Identify Object',
    PreservationManager::EventType::IDENTIFY_FILE_FORMAT => 'Identify File Format',
    PreservationManager::EventType::REVIEW_OBJ => 'Review Object',
    PreservationManager::EventType::REVIEW_BATCH => 'Review Batch',
    PreservationManager::EventType::WRITE_OBJ_LOCAL => 'Write Object Local',
    PreservationManager::EventType::CREATE_OBJ => 'Create Object',
    PreservationManager::EventType::UPDATE_OBJ => 'Update Object',
    PreservationManager::EventType::UPDATE_OBJ_METADATA => 'Update Object Metadata',
    PreservationManager::EventType::REPLICATE_OBJ_VERSION => 'Replicate Object Version',
    PreservationManager::EventType::COMPLETE_OBJ_INGEST => 'Complete Object Ingest',
    PreservationManager::EventType::COMPLETE_BATCH_INGEST => 'Complete Batch Ingest',
    PreservationManager::EventType::DELETE_BAG => 'Delete Bag',
    PreservationManager::EventType::VALIDATE_OBJ_LOCAL => 'Validate Object Local',
    PreservationManager::EventType::VALIDATE_OBJ_VERSION_LOCAL => 'Validate Object Version Local',
    PreservationManager::EventType::VALIDATE_OBJ_VERSION_REMOTE => 'Validate Object Version Remote',
    PreservationManager::EventType::RESTORE_OBJ_VERSION => 'Restore Object Version',
    PreservationManager::EventType::PREPARE_DIP => 'Prepare DIP',
    PreservationManager::EventType::DELETE_OBJ => 'Delete Object'
  }.freeze

  EVENT_OUTCOMES = {
    PreservationManager::EventOutcome::SUCCESS => 'Success',
    PreservationManager::EventOutcome::FAILURE => 'Failure',
    PreservationManager::EventOutcome::SUCCESS_WITH_WARNINGS => 'Warning',
    PreservationManager::EventOutcome::APPROVED => 'Approved',
    PreservationManager::EventOutcome::REJECTED => 'Rejected',
    PreservationManager::EventOutcome::NOT_EXECUTED => 'Not Executed'
  }.freeze

  def initialize(event)
    @type = EVENT_TYPES[event[:type]]
    @outcome = EVENT_OUTCOMES[event[:outcome]]
    @timestamp = event[:eventTimestamp]
    @logs = event[:logs]
    @username = event[:username]
  end

  def failure?
    outcome == EVENT_OUTCOMES[PreservationManager::EventOutcome::FAILURE]
  end

  def success_with_warning?
    outcome == EVENT_OUTCOMES[PreservationManager::EventOutcome::SUCCESS_WITH_WARNINGS]
  end
end
