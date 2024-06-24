# frozen_string_literal: true

require 'rails_helper'
require 'shared/admin_user'

RSpec.describe '/vaults', type: :request do
  include_context 'with admin user'

  let(:org_name) do
    'org1'
  end

  let(:valid_attributes) do
    { name: 'Allowed_Name-1', description: 'valid description' }
  end

  let(:invalid_attributes) do
    { name: 'not@llowed', description: 'valid description' }
  end

  let(:members_hash) do
    { contributor_list: [], viewer_list: [] }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      allow(Vault).to receive(:all).and_return([])

      get organization_vaults_path(org_name)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_organization_vault_path(org_name)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders not found' do
      allow(Vault).to receive(:find).and_raise(PreservationManagerProxy::NotFound)
      get vault_path('not_vault')
      expect(response).to have_http_status(:not_found)
    end

    it 'renders member_show view' do
      vault = Vault.new({ name: 'vault1',
                          description: 'valid description',
                          user_permissions: %w[WRITE READ] })
      allow(Vault).to receive(:find).and_return(vault)
      allow(vault).to receive_messages(members: members_hash, objects_with_storage_problems: [])

      service = SearchBatches.new({}, 'org1', {})
      search_response = SearchBatchesSuccess.new([], 0, 0, 0)
      allow(SearchBatches).to receive(:new).and_return(service)
      allow(service).to receive(:call).and_return(search_response)

      get vault_path('vault1')
      expect(response).to be_successful
      expect(response.body).to include('<h2>Preservation Objects</h2>')
    end

    it 'renders general_show view' do
      vault = Vault.new({ name: 'vault1',
                          description: 'valid description',
                          user_permissions: [] })
      allow(Vault).to receive(:find).and_return(vault)
      allow(vault).to receive(:members).and_return(members_hash)

      get vault_path('vault1')
      expect(response).to be_successful
      expect(response.body).to include('You are not a member of this vault. If you need to view or contribute content, please contact your organization administrator.')
    end

    context 'with service admin' do
      before do
        service_admin = { user: { username: 'service-admin-1',
                                  displayName: 'Service Admin 1',
                                  enabled: true,
                                  userType: PreservationManager::UserType::SERVICE_ADMIN } }

        allow($preservation_manager_proxy).to receive(:describe_user)
          .and_return(PreservationManager::DescribeUserResponse.new(service_admin))
      end

      it 'renders member_show view for service admin' do
        vault = Vault.new({ name: 'vault1',
                            description: 'valid description',
                            user_permissions: [] })
        allow(Vault).to receive(:find).and_return(vault)
        allow(vault).to receive_messages(members: members_hash, objects_with_storage_problems: [])

        service = SearchBatches.new({}, 'org1', {})
        search_response = SearchBatchesSuccess.new([], 0, 0, 0)
        allow(SearchBatches).to receive(:new).and_return(service)
        allow(service).to receive(:call).and_return(search_response)

        get vault_path('vault1')
        expect(response).to be_successful
        expect(response.body).to include('<h2>Preservation Objects</h2>')
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'redirects to the new vault' do
        vault = Vault.new(valid_attributes)
        allow(Vault).to receive(:new).and_return(vault)
        allow(vault).to receive(:save_vault).and_return(true)

        post organization_vaults_path(org_name), params: { vault: valid_attributes }
        expect(response).to redirect_to(vault_path(valid_attributes[:name]))
      end
    end

    context 'with invalid parameters' do
      it 'redirects to vault new' do
        post organization_vaults_path(org_name), params: { vault: invalid_attributes }
        expect(response).to redirect_to(new_organization_vault_path)
      end
    end
  end
end
