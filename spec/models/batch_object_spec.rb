# frozen_string_literal: true

require 'rails_helper'

describe BatchObject do
  describe 'find' do
    before do
      batch_object = { batch_object: { ingestId: 1,
                                       externalObjectId: 'object1',
                                       state: PreservationManager::IngestObjectState::PENDING_REVIEW,
                                       reviewedBy: nil,
                                       hasAnalysisErrors: false,
                                       hasAnalysisWarnings: false } }

      allow($preservation_manager_proxy).to receive(:retrieve_batch_object)
        .and_return(PreservationManager::RetrieveBatchObjectResponse.new(batch_object))
    end

    it 'finds the batch object' do
      batch_object = described_class.find('object1', 1, test_user_proxy_header)
      expected = { id: 'object1',
                   batch_id: 1,
                   state: PreservationManager::IngestObjectState::PENDING_REVIEW,
                   reviewed_by: nil,
                   warnings: false,
                   errors: false }

      expect(batch_object).to have_attributes(expected)
    end
  end

  describe 'files' do
    it 'returns early when analysis failed' do
      batch_object = described_class.new({ state: PreservationManager::IngestObjectState::ANALYSIS_FAILED })

      expect(batch_object.files(test_user_proxy_header)).to be_empty
    end
  end

  describe 'file_diffs' do
    it 'returns file_diffs' do
      diff = { files: [{ path: 'path.xml',
                         newSha256Digest: nil,
                         oldSha256Digest: nil,
                         diff: 'ADDED',
                         formatDiff: { added: [], removed: [], unchanged: [] },
                         encodingDiff: { added: [], removed: [], unchanged: [] },
                         validityDiff: { added: [], removed: [], unchanged: [] } }],
               has_changes: true }

      allow($preservation_manager_proxy).to receive(:diff_batch_object)
        .and_return(PreservationManager::DiffBatchObjectResponse.new(diff))

      batch_object = described_class.new({ externalObjectId: 1,
                                           ingestId: 1,
                                           state: PreservationManager::IngestObjectState::PENDING_REJECTION })

      expect(batch_object.file_diffs(test_user_proxy_header)).to be_present
    end

    it 'returns early when analysis failed' do
      batch_object = described_class.new({ state: PreservationManager::IngestObjectState::ANALYSIS_FAILED })

      expect(batch_object.file_diffs(test_user_proxy_header)).to be_empty
    end
  end
end
