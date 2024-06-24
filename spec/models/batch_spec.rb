# frozen_string_literal: true

require 'rails_helper'

describe Batch do
  describe 'find' do
    before do
      ingest_batch = { ingest_batch: { ingestId: 1,
                                       orgName: 'org1',
                                       vault: 'vault1',
                                       createdBy: 'user1',
                                       reviewedBy: nil,
                                       state: PreservationManager::IngestBatchState::PENDING_REVIEW,
                                       originalFilename: 'original.zip',
                                       fileSize: 46_047_807,
                                       receivedTimestamp: '2021-08-11T14:48:37.991164Z',
                                       updatedTimestamp: '2021-08-11T14:48:42.08925Z' } }

      allow($preservation_manager_proxy).to receive(:retrieve_batch)
        .and_return(PreservationManager::RetrieveBatchResponse.new(ingest_batch))
    end

    it 'finds the batch' do
      expected_batch = { id: 1,
                         org_name: 'org1',
                         vault: 'vault1',
                         created_by: 'user1',
                         reviewed_by: nil,
                         state: PreservationManager::IngestBatchState::PENDING_REVIEW,
                         original_filename: 'original.zip',
                         file_size: 46_047_807,
                         received: '2021-08-11T14:48:37.991164Z',
                         updated: '2021-08-11T14:48:42.08925Z' }

      batch = described_class.find(expected_batch[:id], test_user_proxy_header)
      expect(batch).to have_attributes(expected_batch)
    end
  end

  describe 'review_required?' do
    it 'returns false' do
      batch = described_class.new(state: PreservationManager::IngestBatchState::COMPLETE)
      expect(batch.review_required?).to be(false)
    end

    it 'returns true when pending review' do
      batch = described_class.new(state: PreservationManager::IngestBatchState::PENDING_REVIEW)
      expect(batch.review_required?).to be(true)
    end

    it 'returns true when received' do
      batch = described_class.new(state: PreservationManager::IngestBatchState::RECEIVED)
      expect(batch.review_required?).to be(true)
    end

    it 'returns true when analyzing' do
      batch = described_class.new(state: PreservationManager::IngestBatchState::ANALYZING)
      expect(batch.review_required?).to be(true)
    end
  end

  describe 'pending_review?' do
    it 'returns false' do
      batch = described_class.new(state: PreservationManager::IngestBatchState::COMPLETE)
      expect(batch.pending_review?).to be(false)
    end

    it 'returns true' do
      batch = described_class.new(state: PreservationManager::IngestBatchState::PENDING_REVIEW)
      expect(batch.pending_review?).to be(true)
    end

    it 'returns false when received' do
      batch = described_class.new(state: PreservationManager::IngestBatchState::RECEIVED)
      expect(batch.pending_review?).to be(false)
    end

    it 'returns false when analyzing' do
      batch = described_class.new(state: PreservationManager::IngestBatchState::ANALYZING)
      expect(batch.pending_review?).to be(false)
    end
  end

  describe 'submit_review' do
    context 'with valid params' do
      it 'returns true when approved' do
        allow($preservation_manager_proxy).to receive(:approve_ingest_batch)

        batch = described_class.new({})
        expect(batch.submit_review('approve', test_user_proxy_header)).to be(true)
      end

      it 'returns true when rejected' do
        allow($preservation_manager_proxy).to receive(:reject_ingest_batch)

        batch = described_class.new({})
        expect(batch.submit_review('reject', test_user_proxy_header)).to be(true)
      end

      it 'returns false when BadRequest' do
        allow($preservation_manager_proxy).to receive(:reject_ingest_batch)
          .and_raise(PreservationManagerProxy::BadRequest)

        batch = described_class.new({})
        expect(batch.submit_review('reject', test_user_proxy_header)).to be(false)
      end
    end

    context 'with invalid params' do
      it 'returns false when not valid' do
        batch = described_class.new({})
        expect(batch.submit_review('not_valid', test_user_proxy_header)).to be(false)
      end

      it 'returns false when blank' do
        batch = described_class.new({})
        expect(batch.submit_review('', test_user_proxy_header)).to be(false)
      end

      it 'returns false when nil' do
        batch = described_class.new({})
        expect(batch.submit_review(nil, test_user_proxy_header)).to be(false)
      end
    end
  end
end
