# frozen_string_literal: true

require 'rails_helper'

describe Organization do
  describe 'all organizations' do
    it 'returns an organization' do
      user_orgs = { orgs: [orgName: 'org1',
                           displayName: 'Organization 1',
                           role: PreservationManager::Role::ADMIN,
                           authorities: %w[ADMIN_OPS BASIC_OPS]] }

      allow($preservation_manager_proxy).to receive(:list_user_orgs)
        .and_return(PreservationManager::ListUserOrgsResponse.new(user_orgs))

      actual_org = described_class.all(test_user_proxy_header)
                                  .first

      expected_attr = { display_name: 'Organization 1',
                        name: 'org1',
                        user_role: PreservationManager::Role::ADMIN,
                        user_authorities: %w[ADMIN_OPS BASIC_OPS] }

      expect(actual_org).to have_attributes(expected_attr)
    end
  end

  describe 'all_with_storage' do
    it 'returns organizations with storage details' do
      org1 = { orgName: 'org1',
               displayName: 'organization 1',
               objectCount: 5,
               storageMegabytes: 15 }

      system_storage =
        PreservationManager::SystemStorageResponse.new(total_object_count: 5,
                                                       total_storage_megabytes: 15,
                                                       organizations: [org1])
      allow($preservation_manager_proxy).to receive(:get_system_storage).and_return(system_storage)

      organizations_with_storage = described_class.all_with_storage(test_user_proxy_header)

      expected_org = { name: 'org1',
                       display_name: 'organization 1',
                       object_count: 5,
                       storage_megabytes: 15 }

      expect(organizations_with_storage[:total_objects]).to eq(5)
      expect(organizations_with_storage[:total_storage]).to eq(15)
      expect(organizations_with_storage[:organizations].first).to have_attributes(expected_org)
    end
  end

  describe 'admin?' do
    context 'with standard user' do
      it 'returns false' do
        org = described_class.new(name: 'org1',
                                  display_name: 'Organization 1',
                                  user_role: PreservationManager::Role::STANDARD,
                                  user_authorities: %w[BASIC_OPS])

        expect(org.admin?).to be(false)
      end
    end

    context 'with admin user' do
      it 'returns true' do
        org = described_class.new(name: 'org1',
                                  display_name: 'Organization 1',
                                  user_role: PreservationManager::Role::ADMIN,
                                  user_authorities: %w[ADMIN_OPS BASIC_OPS])

        expect(org.admin?).to be(true)
      end
    end
  end
end
