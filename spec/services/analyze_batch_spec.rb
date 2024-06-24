# frozen_string_literal: true

require 'rails_helper'

describe AnalyzeBatch do
  describe 'analyze batch' do
    context 'with valid parameters' do
      it 'returns batch analysis error when the batch has a failure state' do
        event_arr = [Event.new({ outcome: PreservationManager::EventOutcome::SUCCESS, logs: [] })]
        batch = Batch.new(state: PreservationManager::IngestBatchState::ANALYSIS_FAILED)

        batch_analysis = described_class.new(1, 0, event_arr, batch).call

        expect(batch_analysis.success?).to be(true)
        expect(batch_analysis.message).to eq(described_class::BATCH_ANALYSIS_ERROR)
      end

      it 'returns batch analysis error when there are objects with errors' do
        event_arr = [Event.new({ outcome: PreservationManager::EventOutcome::SUCCESS, logs: [] })]
        batch = Batch.new(state: PreservationManager::IngestBatchState::PENDING_INGESTION)

        batch_analysis = described_class.new(0, 1, event_arr, batch).call

        expect(batch_analysis.success?).to be(true)
        expect(batch_analysis.message).to eq(described_class::BATCH_ANALYSIS_ERROR)
      end

      it 'returns batch analysis error when there is an event failure' do
        event_arr = [Event.new({ outcome: PreservationManager::EventOutcome::SUCCESS, logs: [] }),
                     Event.new({ outcome: PreservationManager::EventOutcome::FAILURE, logs: [] }),
                     Event.new({ outcome: PreservationManager::EventOutcome::SUCCESS, logs: [] })]
        batch = Batch.new(state: PreservationManager::IngestBatchState::PENDING_REVIEW)

        batch_analysis = described_class.new(0, 0, event_arr, batch).call

        expect(batch_analysis.success?).to be(true)
        expect(batch_analysis.message).to eq(described_class::BATCH_ANALYSIS_ERROR)
      end

      it 'returns batch analysis warn when there are objects with warnings' do
        event_arr = [Event.new({ outcome: PreservationManager::EventOutcome::SUCCESS, logs: [] })]
        batch = Batch.new(state: PreservationManager::IngestBatchState::PENDING_REVIEW)

        batch_analysis = described_class.new(1, 0, event_arr, batch).call

        expect(batch_analysis.success?).to be(true)
        expect(batch_analysis.message).to eq(described_class::BATCH_ANALYSIS_WARN)
      end

      it 'returns batch analysis warn when there are event warnings' do
        event_arr = [Event.new({ outcome: PreservationManager::EventOutcome::SUCCESS, logs: [] }),
                     Event.new({ outcome: PreservationManager::EventOutcome::SUCCESS_WITH_WARNINGS, logs: [] })]

        batch = Batch.new(state: PreservationManager::IngestBatchState::PENDING_REVIEW)

        batch_analysis = described_class.new(0, 0, event_arr, batch).call

        expect(batch_analysis.success?).to be(true)
        expect(batch_analysis.message).to eq(described_class::BATCH_ANALYSIS_WARN)
      end

      it 'returns batch analysis success' do
        event_arr = [Event.new({ outcome: PreservationManager::EventOutcome::SUCCESS, logs: [] }),
                     Event.new({ outcome: PreservationManager::EventOutcome::SUCCESS, logs: [] })]

        batch = Batch.new(state: PreservationManager::IngestBatchState::PENDING_REVIEW)

        batch_analysis = described_class.new(0, 0, event_arr, batch).call

        expect(batch_analysis.success?).to be(true)
        expect(batch_analysis.message).to eq(described_class::BATCH_ANALYSIS_SUCCESS)
      end

      it 'returns analysis unavailable when the state is temporary' do
        event_arr = [Event.new({ outcome: PreservationManager::EventOutcome::APPROVED, logs: [] }),
                     Event.new({ outcome: PreservationManager::EventOutcome::SUCCESS, logs: [] }),
                     Event.new({ outcome: PreservationManager::EventOutcome::SUCCESS, logs: [] })]

        batch = Batch.new(state: PreservationManager::IngestBatchState::PENDING_INGESTION)

        batch_analysis = described_class.new(0, 0, event_arr, batch).call

        expect(batch_analysis.success?).to be(true)
        expect(batch_analysis.message).to eq(described_class::BATCH_ANALYSIS_UNAVAILABLE)
      end
    end

    context 'with invalid parameters' do
      it 'returns false' do
        batch_analysis = described_class.new(nil, nil, nil, nil).call

        expect(batch_analysis.success?).to be(false)
      end
    end
  end
end
