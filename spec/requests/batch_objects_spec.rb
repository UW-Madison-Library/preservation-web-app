# frozen_string_literal: true

require 'rails_helper'
require 'shared/admin_user'

RSpec.describe 'BatchObjects', type: :request do
  include_context 'with admin user'
  describe 'GET /index' do
    context 'with valid batch id' do
      it 'returns http success' do
        batch = Batch.new({ ingestId: 1,
                            orgName: 'org1',
                            vault: 'vault1',
                            state: PreservationManager::IngestBatchState::PENDING_REVIEW })

        allow(Batch).to receive(:find).and_return(batch)

        service = SearchBatchObjects.new({}, batch.id, {})
        search_response = SearchBatchObjectsSuccess.new([], 0, 0)
        allow(SearchBatchObjects).to receive(:new).and_return(service)
        allow(service).to receive(:call).and_return(search_response)

        get batch_objects_path(batch.id)
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid batch id' do
      it 'displays not found' do
        # Stub that batch 1 does not exist
        allow(Batch).to receive(:find).and_raise(PreservationManagerProxy::NotFound)
        get batch_objects_path(1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
