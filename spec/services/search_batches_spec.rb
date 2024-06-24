# frozen_string_literal: true

require 'rails_helper'

describe SearchBatches do
  let(:org_name) { 'org1' }
  let(:vault) { 'vault1' }
  let(:state) { PreservationManager::IngestBatchState::PENDING_REVIEW }
  let(:id) { 1 }

  let(:expected) do
    { state: state, reviewed_by: nil, org_name: org_name, id: id, vault: vault }
  end

  let(:search_batches_response) do
    { batches: [{ ingestId: id,
                  orgName: org_name,
                  vault: vault,
                  createdBy: nil,
                  reviewedBy: nil,
                  state: state,
                  originalFilename: nil,
                  fileSize: nil,
                  receivedTimestamp: nil,
                  updatedTimestamp: nil }],
      total_results: 1,
      total_pages: 1,
      page: 0 }
  end

  describe 'search batch' do
    context 'without query params' do
      it 'accepts empty strings in query params' do
        search_init = described_class.new({ vault: '', state: '' },
                                          org_name,
                                          test_user_proxy_header)

        expect(search_init.instance_variable_get(:@vaults)).to be_nil
        expect(search_init.instance_variable_get(:@state)).to be_nil
      end

      it 'accepts no query params' do
        search_init = described_class.new({},
                                          org_name,
                                          test_user_proxy_header)

        expect(search_init.instance_variable_get(:@vaults)).to be_nil
        expect(search_init.instance_variable_get(:@state)).to be_nil
      end
    end

    it 'finds batch with vault and state' do
      allow($preservation_manager_proxy).to receive(:search_batches)
        .and_return(PreservationManager::BatchSearchResponse.new(search_batches_response))

      search_response = described_class.new({ vault: vault, state: state },
                                            org_name,
                                            test_user_proxy_header).call

      expect(search_response.total_results).to eq(1)
      expect(search_response.batches.first).to have_attributes(expected)
      expect(search_response.success?).to be(true)
    end

    it 'finds batch with vault, state, and page' do
      allow($preservation_manager_proxy).to receive(:search_batches)
        .and_return(PreservationManager::BatchSearchResponse.new(search_batches_response))

      search_response = described_class.new({ vault: vault, state: state, page: '0' },
                                            org_name,
                                            test_user_proxy_header).call

      expect(search_response.total_results).to eq(1)
      expect(search_response.batches.first).to have_attributes(expected)
      expect(search_response.success?).to be(true)
    end

    it 'returns error when an invalid state is submitted' do
      search_response = described_class.new({ vault: vault, state: 'Invalid' },
                                            org_name,
                                            test_user_proxy_header).call

      expect(search_response.success?).to be(false)
      expect(search_response.error).to be(described_class::ERROR_MESSAGE)
    end

    it 'returns error when an invalid page is submitted' do
      search_response = described_class.new({ vault: vault,
                                              state: PreservationManager::IngestBatchState::PENDING_REJECTION,
                                              page: '0x' },
                                            org_name,
                                            test_user_proxy_header).call

      expect(search_response.success?).to be(false)
      expect(search_response.error).to be(described_class::ERROR_MESSAGE)
    end
  end
end
