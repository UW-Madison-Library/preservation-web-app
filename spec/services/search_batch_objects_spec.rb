# frozen_string_literal: true

require 'rails_helper'

describe SearchBatchObjects do
  let(:batch_objects_response) do
    { batch_objects: [{ ingestId: 1,
                        externalObjectId: 'object1',
                        state: PreservationManager::IngestObjectState::PENDING_REVIEW,
                        reviewedBy: nil,
                        hasAnalysisErrors: false,
                        hasAnalysisWarnings: false }],
      page: 0,
      total_pages: 1,
      total_results: 1 }
  end

  let(:expected) do
    { batch_id: 1,
      id: 'object1',
      state: PreservationManager::IngestObjectState::PENDING_REVIEW,
      reviewed_by: nil,
      errors: false,
      warnings: false }
  end

  describe 'search batch objects' do
    context 'without query params' do
      before do
        allow($preservation_manager_proxy).to receive(:retrieve_batch_objects)
          .and_return(PreservationManager::RetrieveBatchObjectsResponse.new(batch_objects_response))
      end

      it 'finds batch object with empty strings in query params' do
        search_response = described_class.new({ page: '', has_problems: '' },
                                              1, # batch id
                                              test_user_proxy_header).call

        expect(search_response.success?).to be(true)
        expect(search_response.total_results).to eq(1)
        expect(search_response.batch_objects.first).to have_attributes(expected)
      end

      it 'finds batch object with no query params' do
        search_response = described_class.new({},
                                              1, # batch id
                                              test_user_proxy_header).call

        expect(search_response.success?).to be(true)
        expect(search_response.total_results).to eq(1)
        expect(search_response.batch_objects.first).to have_attributes(expected)
      end
    end

    it 'finds batch object with no_issues filter' do
      allow($preservation_manager_proxy).to receive(:retrieve_batch_objects)
        .and_return(PreservationManager::RetrieveBatchObjectsResponse.new(batch_objects_response))

      search_response = described_class.new({ has_problems: SearchBatchObjects::FILTERS[:no_issues],
                                              page: '0' },
                                            1, # batch id
                                            test_user_proxy_header).call

      expect(search_response.total_results).to eq(1)
      expect(search_response.batch_objects.first).to have_attributes(expected)
      expect(search_response.success?).to be(true)
    end

    it 'returns error for invalid problem' do
      search_response = described_class.new({ has_problems: 'Invalid' },
                                            1, # batch id
                                            test_user_proxy_header).call

      expect(search_response.success?).to be(false)
      expect(search_response.error).to be_present
    end

    it 'returns error for invalid page' do
      search_response = described_class.new({ page: '0x' },
                                            1, # batch id
                                            test_user_proxy_header).call

      expect(search_response.success?).to be(false)
      expect(search_response.error).to be_present
    end
  end
end
