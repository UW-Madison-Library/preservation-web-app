# frozen_string_literal: true

AnalyzeBatchFailure = Struct.new(:error) do
  def success?
    false
  end
end

AnalyzeBatchSuccess = Struct.new(:message) do
  def success?
    true
  end
end

class AnalyzeBatch
  BATCH_ANALYSIS_WARN = 'Warnings Detected'
  BATCH_ANALYSIS_ERROR = 'Errors Detected'
  BATCH_ANALYSIS_SUCCESS = 'No errors or warnings were detected.'
  BATCH_ANALYSIS_UNAVAILABLE = 'The analysis is unavailable for the current batch status.'

  ERROR_MESSAGE = 'A required field for the batch analysis is missing.'

  UNAVAILABLE_STATES = [PreservationManager::IngestBatchState::PENDING_INGESTION,
                        PreservationManager::IngestBatchState::PENDING_REJECTION,
                        PreservationManager::IngestBatchState::INGESTING,
                        PreservationManager::IngestBatchState::REPLICATING,
                        PreservationManager::IngestBatchState::REJECTING].freeze

  def initialize(warning_object_count, error_object_count, events, batch)
    @warning_object_count = warning_object_count
    @error_object_count = error_object_count
    @events = events
    @batch = batch
  end

  def call
    if @warning_object_count.nil? || @error_object_count.nil? || @events.nil? || @batch.nil?
      Rails.logger.error { ERROR_MESSAGE }
      return AnalyzeBatchFailure.new(ERROR_MESSAGE)
    end
    AnalyzeBatchSuccess.new(batch_analysis)
  end

  private

  def batch_analysis
    if errors_detected?
      # Message when there are any errors.
      BATCH_ANALYSIS_ERROR
    elsif UNAVAILABLE_STATES.include?(@batch.state)
      # Message when the batch is in a temporary state.
      # Warnings or errors may be added once the batch transition is complete.
      BATCH_ANALYSIS_UNAVAILABLE
    elsif warnings_detected?
      # Message when there are warnings AND no errors.
      BATCH_ANALYSIS_WARN
    else
      # Message when there are no objects with warnings or errors,
      # the batch status is not a failure state,
      # and there are no events with warnings or failures.
      BATCH_ANALYSIS_SUCCESS
    end
  end

  def errors_detected?
    @error_object_count.positive? || @batch.failure? || @events.any?(&:failure?)
  end

  def warnings_detected?
    @warning_object_count.positive? || @events.any?(&:success_with_warning?)
  end
end
