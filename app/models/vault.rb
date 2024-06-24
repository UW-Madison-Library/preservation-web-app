# frozen_string_literal: true

class Vault
  include ActiveModel::Model

  attr_accessor :name, :description, :user_permissions, :org_name, :approximate_storage_megabytes,
                :object_count

  validates :name, presence: true,
                   length: { in: 4..128 },
                   format: { with: /\A[a-zA-Z0-9 _-]+\z/,
                             message: 'may only include alphanumeric or special characters: -_' }

  validates :description, presence: true, length: { maximum: 255 }

  # user permissions for a vault
  WRITE = 'WRITE'
  READ = 'READ'

  def save_vault(org_name, proxy_header)
    return false unless valid?

    vault = PreservationManager::VaultObject.new(name: name, description: description)

    opts = { body: PreservationManager::CreateVaultRequest.new(org_name: org_name,
                                                               vault: vault) }

    $preservation_manager_proxy.create_vault(opts.merge(proxy_header))

    true
  rescue PreservationManagerProxy::BadRequest
    errors.add(:name, 'is unavailable, please submit a different name.')
    false
  end

  def user_read_access?
    user_permissions&.include?(READ)
  end

  def user_write_access?
    user_permissions&.include?(WRITE)
  end

  def user_access?
    user_permissions.present?
  end

  # Returns a hash with a contributor list and a viewer list for the current vault
  # rubocop:disable Metrics/MethodLength
  def members(proxy_header)
    members = { contributor_list: [], viewer_list: [] }

    # Vault names may have spaces, and the spaces must be percent encoded before being passed to
    # the preservation manager. This solution works because spaces are the only characters allowed
    # in a vault name that need to be escaped.
    escaped_name = name.gsub(' ', '%20')
    users = $preservation_manager_proxy.list_users_in_vault(escaped_name, proxy_header).users

    users.each do |user|
      next if user[:userType] == PreservationManager::UserType::PROGRAMMATIC_USER

      if user[:permissions].include?(Vault::WRITE)
        members[:contributor_list] << user[:displayName]
      else
        members[:viewer_list] << user[:displayName]
      end
    end

    members
  end
  # rubocop:enable Metrics/MethodLength

  def objects_with_storage_problems(proxy_header)
    # Vault names may have spaces, and the spaces must be percent encoded before being passed to
    # the preservation manager. This solution works because spaces are the only characters allowed
    # in a vault name that need to be escaped.
    escaped_name = name.gsub(' ', '%20')

    $preservation_manager_proxy.list_vault_problems(escaped_name, proxy_header).objects
  end

  # Returns an array of Vaults that the current user has write access to
  def self.all_write_access(org_name, proxy_header)
    vaults = $preservation_manager_proxy.list_org_user_vault_permissions(org_name, proxy_header)
                                        .vault_permissions

    vaults.filter_map do |vault|
      if vault[:permissions].include?(WRITE)
        Vault.new(name: vault[:vault][:name],
                  description: vault[:vault][:description],
                  user_permissions: vault[:permissions])
      end
    end
  end

  # Returns an array of all Vaults in the specified organization
  def self.all(org_name, proxy_header)
    vaults = $preservation_manager_proxy.list_org_user_vault_permissions(org_name, proxy_header)
                                        .vault_permissions

    vaults.map do |vault|
      Vault.new(name: vault[:vault][:name],
                description: vault[:vault][:description],
                user_permissions: vault[:permissions])
    end
  end

  # Returns a Vault if it exists in the organization
  def self.find(name, proxy_header)
    # Vault names may have spaces, and the spaces must be percent encoded before being passed to
    # the preservation manager. This solution works because spaces are the only characters allowed
    # in a vault name that need to be escaped.
    escaped_name = name.gsub(' ', '%20')

    vault = $preservation_manager_proxy.describe_vault(escaped_name, proxy_header)

    Vault.new(name: vault.vault[:name],
              description: vault.vault[:description],
              user_permissions: vault.permissions,
              org_name: vault.org_name,
              approximate_storage_megabytes: vault.approximate_storage_megabytes,
              object_count: vault.object_count)
  end
end
