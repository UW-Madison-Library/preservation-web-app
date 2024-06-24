# frozen_string_literal: true

require 'rails_helper'
require 'shared/admin_user'

RSpec.describe 'Batches', type: :request do
  include_context 'with admin user'

  let(:pending_batch) do
    Batch.new({ ingestId: 1,
                orgName: 'org1',
                vault: 'vault1',
                state: PreservationManager::IngestBatchState::PENDING_REVIEW })
  end

  let(:complete_batch) do
    Batch.new({ ingestId: 2,
                orgName: 'org1',
                vault: 'vault1',
                state: PreservationManager::IngestBatchState::COMPLETE })
  end

  describe 'GET /index' do
    it 'returns http success' do
      service = SearchBatches.new({}, 'org1', {})
      search_response = SearchBatchesSuccess.new([], 0, 0, 0)
      allow(SearchBatches).to receive(:new).and_return(service)
      allow(service).to receive(:call).and_return(search_response)

      allow(Vault).to receive(:all).and_return([])

      get organization_batches_path('org1')
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      allow(Vault).to receive(:all_write_access).and_return([])

      get new_organization_batch_path('org1')
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    context 'with valid batch id' do
      before do
        service = SearchBatchObjects.new({}, 1, {})
        search_response = SearchBatchObjectsSuccess.new([], 0, 0)
        allow(SearchBatchObjects).to receive(:new).and_return(service)
        allow(service).to receive(:call).and_return(search_response)
      end

      it 'renders a successful response' do
        allow(Batch).to receive(:find).and_return(pending_batch)
        allow(pending_batch).to receive(:events).and_return([])

        get batch_path(pending_batch.id)
        expect(response).to be_successful
      end

      it 'renders a successful response with AnalyzeBatch failure' do
        analyze_batch = AnalyzeBatch.new(nil, nil, nil, nil)
        analysis = AnalyzeBatchFailure.new(AnalyzeBatch::ERROR_MESSAGE)
        allow(AnalyzeBatch).to receive(:new).and_return(analyze_batch)
        allow(analyze_batch).to receive(:call).and_return(analysis)

        allow(Batch).to receive(:find).and_return(pending_batch)
        allow(pending_batch).to receive(:events).and_return([])

        get batch_path(pending_batch.id)
        expect(response).to be_successful
      end
    end

    context 'with invalid batch id' do
      it 'displays not found' do
        # Stub that batch 1 does not exist
        allow(Batch).to receive(:find).and_raise(PreservationManagerProxy::NotFound)
        get batch_path(1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /edit' do
    before do
      service = SearchBatchObjects.new({}, 1, {})
      search_response = SearchBatchObjectsSuccess.new([], 0, 0)
      allow(SearchBatchObjects).to receive(:new).and_return(service)
      allow(service).to receive(:call).and_return(search_response)
    end

    context 'with write permission' do
      before do
        allow(Vault).to receive(:find).and_return(Vault.new(user_permissions: %w[READ WRITE]))
      end

      it 'render a successful response' do
        allow(Batch).to receive(:find).and_return(pending_batch)
        allow(pending_batch).to receive(:events).and_return([])

        get edit_batch_path(pending_batch.id)
        expect(response).to be_successful
      end

      it 'redirects when approved' do
        allow(Batch).to receive(:find).and_return(complete_batch)
        allow(complete_batch).to receive(:events).and_return([])

        get edit_batch_path(complete_batch.id)
        expect(response).to redirect_to(batch_path)
      end

      it 'redirects when rejected' do
        batch = Batch.new(ingestId: 1,
                          orgName: 'org1',
                          vault: 'vault1',
                          state: PreservationManager::IngestBatchState::REJECTED)
        allow(Batch).to receive(:find).and_return(batch)
        allow(batch).to receive(:events).and_return([])

        get edit_batch_path(batch.id)
        expect(flash[:alert]).to be_present
        expect(response).to redirect_to(batch_path)
      end

      it 'flashes notice when analyzing' do
        batch = Batch.new({ ingestId: 1,
                            orgName: 'org1',
                            vault: 'vault1',
                            state: PreservationManager::IngestBatchState::ANALYZING })
        allow(Batch).to receive(:find).and_return(batch)
        allow(batch).to receive(:events).and_return([])

        get edit_batch_path(batch.id)
        expect(flash[:notice]).to be_present
        expect(response).to be_successful
      end

      it 'flashes notice when received' do
        batch = Batch.new({ ingestId: 1,
                            orgName: 'org1',
                            vault: 'vault1',
                            state: PreservationManager::IngestBatchState::RECEIVED })
        allow(Batch).to receive(:find).and_return(batch)
        allow(batch).to receive(:events).and_return([])

        get edit_batch_path(batch.id)
        expect(flash[:notice]).to be_present
        expect(response).to be_successful
      end
    end

    context 'without write permission' do
      before do
        allow(Vault).to receive(:find).and_return(Vault.new(user_permissions: %w[READ]))
      end

      it 'is successful' do
        allow(Batch).to receive(:find).and_return(pending_batch)
        allow(pending_batch).to receive(:events).and_return([])

        get edit_batch_path(pending_batch.id)
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the batch as approved' do
        allow(Batch).to receive(:find).and_return(pending_batch)
        allow(pending_batch).to receive(:submit_review).and_return(true)

        patch batch_path(pending_batch.id), params: { review: 'approve' }

        expect(response).to redirect_to(batch_path)
      end

      it 'updates the batch as rejected' do
        allow(Batch).to receive(:find).and_return(pending_batch)
        allow(pending_batch).to receive(:submit_review).and_return(true)

        patch batch_path(pending_batch.id), params: { review: 'reject' }

        expect(response).to redirect_to(batch_path)
      end
    end

    context 'with invalid parameters' do
      it 'requires the user to review the batch' do
        allow(Batch).to receive(:find).and_return(pending_batch)
        allow(pending_batch).to receive(:submit_review).and_return(false)

        patch batch_path(pending_batch.id)

        expect(response).to redirect_to(edit_batch_path)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'redirects to the created batch' do
        ingest_response = IngestBagSuccess.new(1)
        service = IngestBag.new({}, {})

        allow(IngestBag).to receive(:new).and_return(service)
        allow(service).to receive(:call).and_return(ingest_response)

        post organization_batches_path('org1'), params: { batch: { vault: 'vault', bag: 'upload' } }

        expect(response).to redirect_to(edit_batch_path(1))
      end
    end

    context 'with invalid parameters' do
      it 'redirects to new batch view' do
        service = IngestBag.new({}, {})
        ingest_response = IngestBagFailure.new(IngestBag::MISSING_PARAM_MESSAGE)

        allow(IngestBag).to receive(:new).and_return(service)
        allow(service).to receive(:call).and_return(ingest_response)

        post organization_batches_path('org1', params: { batch: { vault: 'not_vault', bag: nil } })
        expect(response).to redirect_to(new_organization_batch_path('org1'))
        expect(flash[:alert]).to be_present
      end
    end
  end
end
