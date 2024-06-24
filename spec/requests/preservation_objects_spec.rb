# frozen_string_literal: true

require 'rails_helper'
require 'shared/admin_user'

RSpec.describe '/preservation_objects', type: :request do
  include_context 'with admin user'

  describe 'GET /display' do
    before do
      vault = Vault.new(name: 'vault1', org_name: 'org1')
      allow(Vault).to receive(:find).and_return(vault)
    end

    context 'with invalid preservation object' do
      it 'displays not found for not found' do
        allow(PreservationObject).to receive(:find).and_raise(PreservationManagerProxy::NotFound)
        get vault_preservation_objects_display_path('vault1',
                                                    params: { preservation_object_id: 'this is not an object id' })
        expect(response).to have_http_status(:not_found)
      end

      it 'displays not found for bad request' do
        allow(PreservationObject).to receive(:find).and_raise(PreservationManagerProxy::BadRequest)
        get vault_preservation_objects_display_path('vault1',
                                                    params: { preservation_object_id: '' })
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with valid presrvation object' do
      it 'is successful' do
        api_response = PreservationManager::DescribePreservationObjectResponse.new(
          external_object_id: 'object1',
          vault: 'vault1',
          files: [],
          remote_version_check: [],
          ingest_id: 1,
          version: 1,
          latest_version: 1
        )

        pres_object = PreservationObject.new(api_response)
        allow(PreservationObject).to receive(:find).and_return(pres_object)
        allow(pres_object).to receive_messages(events: [], storage_problems: [])
        get vault_preservation_objects_display_path('vault1',
                                                    params: { preservation_object_id: 'object1' })
        expect(response).to be_successful
      end
    end
  end
end
