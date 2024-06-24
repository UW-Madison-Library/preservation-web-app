# frozen_string_literal: true

require 'rails_helper'

describe SearchPreservationObjects do
  describe 'search preservation object' do
    context 'with invalid parameters' do
      it 'returns search message with nil id' do
        search_response = described_class.new('vault1', nil, test_user_proxy_header).call

        expect(search_response.error).to eq(described_class::START_SEARCH_MESSAGE)
        expect(search_response.success?).to be(false)
      end

      it 'returns search message with empty string' do
        search_response = described_class.new('vault1', '', test_user_proxy_header).call

        expect(search_response.error).to eq(described_class::START_SEARCH_MESSAGE)
        expect(search_response.success?).to be(false)
      end

      it 'returns not found' do
        allow($preservation_manager_proxy).to receive(:describe_preservation_object)
          .and_raise(PreservationManagerProxy::NotFound)

        search_response = described_class.new('vault1', 'not found', test_user_proxy_header).call

        expect(search_response.error).to eq(described_class::NOT_FOUND_MESSAGE)
        expect(search_response.success?).to be(false)
      end
    end

    context 'with valid parameters' do
      it 'finds a preservation object' do
        pres_obj = { object_created_timestamp: '2022-01-06T21:01:28.417944Z',
                     external_object_id: 'object1',
                     files: [{ filePath: 'file.txt"',
                               sha256Digest: nil,
                               fileSize: 0,
                               formats: [],
                               encoding: [],
                               validity: [] }],
                     ingest_id: 35,
                     latest_version: 1,
                     vault: 'vault1',
                     version: 1 }

        allow($preservation_manager_proxy).to receive(:describe_preservation_object)
          .and_return(PreservationManager::DescribePreservationObjectResponse.new(pres_obj))

        search_response = described_class.new('vault1', 'object1', test_user_proxy_header).call

        expect(search_response.preservation_object).to be_present
        expect(search_response.success?).to be(true)
      end

      it 'removes whitespace from object id' do
        object_search_init = described_class.new('vault1', '   object1  ', test_user_proxy_header)

        expect(object_search_init.instance_variable_get(:@preservation_object_id)).to eq('object1')
      end
    end
  end
end
