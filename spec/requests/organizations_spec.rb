# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/organizations', type: :request do
  describe 'GET /index' do
    it 'renders successfully' do
      stub_describe_user
      org1 = Organization.new(name: 'org1',
                              display_name: 'Organization 1',
                              user_role: 'ADMIN',
                              user_authorities: %w[ADMIN_OPS BASIC_OPS])
      allow(Organization).to receive(:all).and_return([org1])

      get root_path
      expect(response).to be_successful
      expect(response.body).to include('<h1>Organizations</h1>')
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

      it 'renders service_admin_index' do
        org1 = Organization.new(name: 'org1',
                                display_name: 'Organization 1',
                                object_count: 5,
                                storage_megabytes: 10)
        orgs = { total_objects: 5,
                 total_storage: 10,
                 organizations: [org1] }
        allow(Organization).to receive(:all_with_storage).and_return(orgs)

        get root_path
        expect(response).to be_successful
        expect(response.body).to include('<h1>Service Administration Home</h1>')
      end
    end
  end
end
