# frozen_string_literal: true

require 'rails_helper'

describe Vault do
  let(:org_name) do
    'org1'
  end

  let(:read_write) do
    %w[READ WRITE]
  end

  let(:read) do
    %w[READ]
  end

  describe 'save_vault' do
    let(:valid_name) do
      'Allowed_ Name-1'
    end

    let(:valid_description) do
      'valid description'
    end

    it 'saves vault' do
      allow($preservation_manager_proxy).to receive(:create_vault)

      expect(new_vault({ name: valid_name, description: valid_description })).to be(true)
    end

    it 'returns false when BadRequest' do
      allow($preservation_manager_proxy).to receive(:create_vault)
        .and_raise(PreservationManagerProxy::BadRequest)

      expect(new_vault({ name: valid_name, description: valid_description })).to be(false)
    end

    it 'does not save nil vault name' do
      expect(new_vault({ name: nil, description: valid_description })).to be(false)
    end

    it 'does not save nil vault description' do
      expect(new_vault({ name: valid_name, description: nil })).to be(false)
    end

    it 'does not save vault with @' do
      expect(new_vault({ name: 'not@llowed', description: valid_description })).to be(false)
    end

    it 'does not save short vault' do
      expect(new_vault({ name: 'a', description: valid_description })).to be(false)
    end

    it 'does not save long vault' do
      long_name = 'toolongtoolongtoolongtoolongtoolongtoolongtoolongtoolongtoolongtoolongtoolongtoolongtoolongtoolongtoolongtoolongtoolongtoolongtoo'
      expect(new_vault({ name: long_name, description: valid_description })).to be(false)
    end

    def new_vault(vault)
      Vault.new(vault).save_vault(org_name, test_user_proxy_header)
    end
  end

  describe 'all_write_access' do
    it 'returns vaults the user has write access to' do
      permissions = { vault_permissions: [
        { vault: { name: 'vault1', description: 'the first vault' }, permissions: read_write },
        { vault: { name: 'vault2', description: 'the second vault' }, permissions: read },
        { vault: { name: 'vault3', description: 'the third vault' }, permissions: [] }
      ] }
      vault_response = PreservationManager::ListVaultPermissionsResponse.new(permissions)
      allow($preservation_manager_proxy).to receive(:list_org_user_vault_permissions)
        .and_return(vault_response)

      vaults = described_class.all_write_access(org_name, test_user_proxy_header)
      expected = { name: 'vault1', description: 'the first vault', user_permissions: read_write }

      expect(vaults.count).to eq(1)
      expect(vaults.first).to have_attributes(expected)
    end
  end

  describe 'user_read_access?' do
    it 'returns true when read write' do
      vault = described_class.new(name: 'vault1', user_permissions: read_write)

      expect(vault.user_read_access?).to be(true)
    end

    it 'returns true when read only' do
      vault = described_class.new(name: 'vault1', user_permissions: read)

      expect(vault.user_read_access?).to be(true)
    end

    it 'returns false' do
      vault = described_class.new(name: 'no-access', user_permissions: [])

      expect(vault.user_read_access?).to be(false)
    end
  end

  describe 'user_write_access?' do
    it 'returns true' do
      vault = described_class.new(name: 'vault1', user_permissions: read_write)

      expect(vault.user_write_access?).to be(true)
    end

    it 'returns false' do
      vault = described_class.new(name: 'vault2', user_permissions: read)

      expect(vault.user_write_access?).to be(false)
    end
  end

  describe 'members' do
    let(:write_user) do
      { username: 'user1',
        displayName: 'User 1',
        enabledInOrg: true,
        userType: PreservationManager::UserType::GENERAL_USER,
        permissions: read_write }
    end

    let(:read_user) do
      { username: 'user2',
        displayName: 'User 2',
        enabledInOrg: true,
        userType: PreservationManager::UserType::SERVICE_ADMIN,
        permissions: read }
    end

    let(:programmmatic_user) do
      { username: 'programmmatic1',
        displayName: 'Programmatic 1',
        enabledInOrg: true,
        userType: PreservationManager::UserType::PROGRAMMATIC_USER,
        permissions: read_write }
    end

    it 'returns active, general users' do
      users = { users: [write_user, read_user, programmmatic_user] }
      users_response = PreservationManager::ListVaultUsersResponse.new(users)
      allow($preservation_manager_proxy).to receive(:list_users_in_vault).and_return(users_response)

      vault = described_class.new(name: 'vault1')

      members = vault.members(test_user_proxy_header)
      expect(members[:contributor_list]).to eq([write_user[:displayName]])
      expect(members[:viewer_list]).to eq([read_user[:displayName]])
    end
  end

  describe 'find' do
    it 'finds the vault' do
      expected = { name: 'vault1',
                   description: 'vault one',
                   org_name: org_name,
                   user_permissions: read_write }

      vault_obj = { name: expected[:name], description: expected[:description] }
      vault_response = PreservationManager::DescribeVaultResponse.new(vault: vault_obj,
                                                                      org_name: expected[:org_name],
                                                                      permissions: expected[:user_permissions])
      allow($preservation_manager_proxy).to receive(:describe_vault).and_return(vault_response)

      vault = described_class.find('vault1', test_user_proxy_header)

      expect(vault).to be_present
      expect(vault).to have_attributes(expected)
    end
  end
end
